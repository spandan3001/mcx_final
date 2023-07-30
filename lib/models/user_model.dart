import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String number;
  final double wallet;

  const UserModel(
      {required this.id,
      required this.number,
      required this.name,
      required this.email,
      required this.wallet});

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    final String walletMoney = data["wallet"];
    return UserModel(
      id: document.id,
      number: data["number"],
      name: data["name"],
      email: data["email"],
      wallet: double.parse(walletMoney),
    );
  }
}
