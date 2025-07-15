// lib/services/firestore_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/models/conversation.dart';


class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Future<List<Conversation>> fetchConversations() async {
    try {
      final snapshot = await _db
          .collection('conversations')
          //.orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => Conversation.fromMap(doc.id, doc.data()))
          .toList();
    } catch (e) {
      print('❌ Error fetching conversations: $e');
      rethrow;
    }
  }
}
