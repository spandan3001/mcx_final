import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String userId;
  final String email;
  final String type;
  final String token;
  final String placedPoint;
  final String closedPoint;
  final String amount;
  final Timestamp timeStamp;
  final String option;
  final bool isActive;

  const OrderModel({
    required this.userId,
    required this.closedPoint,
    required this.amount,
    required this.token,
    required this.isActive,
    required this.option,
    required this.id,
    required this.timeStamp,
    required this.type,
    required this.placedPoint,
    required this.email,
  });

  factory OrderModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return OrderModel(
      closedPoint: data["closedPoint"],
      id: document.id,
      email: data['email'],
      timeStamp: data['timeStamp'] ?? Timestamp(100, 10),
      type: data['type'],
      userId: data['userId'],
      placedPoint: data['placedPrice'],
      isActive: data['isActive'],
      option: data['option'],
      token: data['commodity'],
      amount: data['amount'],
    );
  }
}
