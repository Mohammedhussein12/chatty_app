import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  static const String collectionName = 'messages';
  String? id;
  final String content;
  final String senderId;
  final String senderName;
  DateTime dateTime;
  final String roomId;

  MessageModel({
    this.id = '',
    required this.content,
    required this.roomId,
    required this.senderId,
    required this.senderName,
    required this.dateTime,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      content: json['message'],
      roomId: json['roomId'],
      senderId: json['senderId'],
      senderName: json['senderName'],
      dateTime: (json['dateTime'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': content,
      'roomId': roomId,
      'senderId': senderId,
      'senderName': senderName,
      'dateTime': FieldValue.serverTimestamp(),
    };
  }
}
