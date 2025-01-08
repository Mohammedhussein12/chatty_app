import 'package:chatty_app/auth/data/models/user_model.dart';
import 'package:chatty_app/chat/view_model/chat_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/database_utils.dart';
import '../data/models/message_model.dart';

class ChatViewModel extends Cubit<ChatStates> {
  ChatViewModel() : super(ChatInitialState());
  final messagesController = TextEditingController();
  late final UserModel currentUser;
  late final String roomId;

  Future<void> sendMessage() async {
    emit(SendMessagesLoading());
    try {
      if (messagesController.text.isEmpty) return;
      final message = MessageModel(
          content: messagesController.text,
          roomId: roomId,
          senderId: currentUser.id,
          senderName: currentUser.name,
          dateTime: DateTime.now());
      messagesController.clear();
      await DatabaseUtils.insertMessageToRoom(message);
      emit(SendMessagesSuccess());
    } catch (error) {
      emit(SendMessagesError(error.toString()));
    }
  }

  Future<void> getMessagesStream() async {
    emit(GetMessagesStreamLoading());
    try {
      final messagesStream = DatabaseUtils.getRoomMessages(roomId);
      emit(GetMessagesStreamSuccess(messagesStream));
    } catch (error) {
      emit(GetMessagesStreamError(error.toString()));
    }
  }

  bool isMyMessage(String messageId) {
    return messageId == currentUser.id;
  }
  @override
  Future<void> close() {
    messagesController.dispose();
    return super.close();
  }
}
