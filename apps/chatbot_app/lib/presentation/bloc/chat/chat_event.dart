sealed class ChatEvent {}

class SendMessage extends ChatEvent {
  final String userMessage;
  SendMessage(this.userMessage);
}

class LoadMessages extends ChatEvent {}

class DeleteAllMessages extends ChatEvent {}
