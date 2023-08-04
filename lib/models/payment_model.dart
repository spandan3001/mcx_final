import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  final String id;
  final String firstName;
  final String? secondName;
  final String email;
  final String number;
  final String refId;
  final String type;
  final bool approved;
  final String amount;

  const PaymentModel({
    required this.firstName,
    this.secondName,
    required this.refId,
    required this.type,
    required this.approved,
    required this.amount,
    required this.id,
    required this.number,
    required this.email,
  });

  factory PaymentModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return PaymentModel(
      refId: data['refId'],
      approved: data['approved'],
      number: data["number"],
      firstName: data["firstName"],
      secondName: data["secondName"],
      email: data["email"],
      id: data["id"],
      amount: data['amount'],
      type: data['type'],
    );
  }
  static Map<String, Object> toMap(PaymentModel paymentModel) {
    return {
      "firstName": paymentModel.firstName,
      "secondName": paymentModel.secondName ?? "",
      "email": paymentModel.email,
      "number": paymentModel.number,
      "id": paymentModel.id,
      "approved": paymentModel.approved,
      "refId": paymentModel.refId,
      "amount": paymentModel.amount,
      "type": paymentModel.type
    };
  }
}
