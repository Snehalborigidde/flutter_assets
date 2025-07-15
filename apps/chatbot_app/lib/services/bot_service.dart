import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class BotService {
  final _firestore = FirebaseFirestore.instance;
  final Gemini gemini = Gemini.instance;

  /// Save message to Firestore
  Future<void> saveMessage(String role, String message) async {
    await _firestore.collection('chats').add({
      'role': role,
      'message': message,
      'deleted': false,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  /// Fetch messages from Firestore
  Future<List<Map<String, dynamic>>> fetchMessages() async {
    final snapshot =
        await _firestore.collection('chats').orderBy('timestamp').get();

    return snapshot.docs
        .map(
          (doc) => {
            'role': doc['role'],
            'message': doc['message'],
            'timestamp': doc['timestamp'],
          },
        )
        .toList();
  }

  /// Get reply from Gemini
  Future<String> getReply(String prompt) async {
    final response = await gemini.text(prompt);
    return response?.output ?? '...';
  }

  /// Soft delete messages
  Future<void> softDeleteAllMessages() async {
    final snapshot = await _firestore.collection('chats').get();
    for (final doc in snapshot.docs) {
      await doc.reference.update({'deleted': true});
    }
  }
}
