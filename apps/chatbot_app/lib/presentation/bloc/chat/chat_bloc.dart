




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/chat_entity.dart';
import '../../../services/bot_service.dart';
import 'chat_event.dart';
import 'chat_state.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final BotService botService;

  ChatBloc(this.botService) : super(ChatInitial()) {
    on<SendMessage>(_onSendMessage);
    on<LoadMessages>(_onLoadMessages);
    on<DeleteAllMessages>(_onDeleteAllMessages);
  }

  Future<void> _onSendMessage(SendMessage event, Emitter<ChatState> emit) async {
    final current = List<ChatMessage>.from(state.messages)
      ..add(ChatMessage(role: 'user', message: event.userMessage, timestamp: DateTime.now(),));
    emit(ChatUpdated(current));

    try {
      // Save user message to Firestore
      await botService.saveMessage('user', event.userMessage);

      // Call Gemini
      final response = await Gemini.instance.text(event.userMessage);
      final botReply = response?.output ?? '...'; // Correct way with flutter_gemini

      // Save bot reply to Firestore
      await botService.saveMessage('bot', botReply);
      final botMessage = ChatMessage(
        role: 'bot',
        message: botReply,
        timestamp: DateTime.now(),
      );
      // Update UI
      current.add(botMessage);
      emit(ChatUpdated(List.from(current)));
    } catch (e) {
      print("❌ Gemini Error: $e");
    }
  }


  Future<void> _onLoadMessages(LoadMessages event, Emitter<ChatState> emit) async {
    try {
      final raw = await botService.fetchMessages();
      final history = raw.map((e) {
        final timestamp = e['timestamp'];
        final dateTime = timestamp is Timestamp ? timestamp.toDate() : DateTime.now();

        return ChatMessage(
          role: e['role'] ?? 'user',
          message: e['message'] ?? '',
          timestamp: dateTime,
        );
      }).toList();

      emit(ChatUpdated(history));
    } catch (e) {
      print("❌ Load failed: $e");
      emit(ChatUpdated([]));
    }
  }

  Future<void> _onDeleteAllMessages(DeleteAllMessages event, Emitter<ChatState> emit) async {
    await botService.softDeleteAllMessages();
    emit(ChatUpdated([]));
  }
}
