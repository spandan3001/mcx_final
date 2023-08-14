import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String id;
  final String text;
  final String email;
  final Timestamp timestamp;
  final String? imageUrl;

  const MessageModel({
    this.imageUrl,
    required this.text,
    required this.id,
    required this.email,
    required this.timestamp,
  });

  factory MessageModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return MessageModel(
      text: data['text'],
      email: data["sender"],
      timestamp: data["timeStamp"] ?? Timestamp(100, 100),
      imageUrl: data['imageUrl'],
      id: document.id,
    );
  }
  static Map<String, Object> toMap(MessageModel userModel) {
    return {
      "email": userModel.email,
      "text": userModel.text,
    };
  }
}
