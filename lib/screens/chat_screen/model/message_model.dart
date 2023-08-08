import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String text;
  final String email;
  final Timestamp timestamp;

  const MessageModel({
    required this.text,
    required this.email,
    required this.timestamp,
  });

  factory MessageModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return MessageModel(
      text: data['text'],
      email: data["sender"],
      timestamp: data["timeStamp"],
    );
  }
  static Map<String, Object> toMap(MessageModel userModel) {
    return {
      "email": userModel.email,
      "text": userModel.text,
    };
  }
}
