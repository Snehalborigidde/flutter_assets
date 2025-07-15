// lib/models/conversation.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  final String id;
  final String title;
  final String lastMessage;
  final DateTime? timestamp; // ⬅️ Make it nullable

  Conversation({
    required this.id,
    required this.title,
    required this.lastMessage,
    this.timestamp,
  });

  factory Conversation.fromMap(String id, Map<String, dynamic> data) {
    return Conversation(
      id: id,
      title: data['title'] ?? '',
      lastMessage: data['lastMessage'] ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate(),
    );
  }
}
