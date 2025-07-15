

import '../../../domain/entities/chat_entity.dart';

sealed class ChatState {
  final List<ChatMessage> messages;
  ChatState(this.messages);
}

class ChatInitial extends ChatState {
  ChatInitial() : super([]);
}

class ChatUpdated extends ChatState {
  ChatUpdated(List<ChatMessage> messages) : super(messages);
}

