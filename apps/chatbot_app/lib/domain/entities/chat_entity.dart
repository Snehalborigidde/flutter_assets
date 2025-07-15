class ChatMessage {
  final String role;
  final String message;
  final DateTime timestamp;

  ChatMessage({
    required this.role,
    required this.message,
    required this.timestamp,
  });
}
