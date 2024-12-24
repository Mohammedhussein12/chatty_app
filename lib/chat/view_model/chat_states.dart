import '../data/models/message_model.dart';

abstract class ChatStates {}

class ChatInitialState extends ChatStates {}

class SendMessagesLoading extends ChatStates {}

class SendMessagesError extends ChatStates {
  final String error;

  SendMessagesError(this.error);
}

class SendMessagesSuccess extends ChatStates {}

class GetMessagesStreamLoading extends ChatStates {}

class GetMessagesStreamError extends ChatStates {
  final String error;

  GetMessagesStreamError(this.error);
}

class GetMessagesStreamSuccess extends ChatStates {
  final Stream<List<MessageModel>> messagesStream;

  GetMessagesStreamSuccess(this.messagesStream);
}
