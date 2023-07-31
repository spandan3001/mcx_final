import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String firstName;
  final String secondName;
  final String email;
  final String number;
  final String gender;
  final String wallet;

  const UserModel(
      {required this.id,
      required this.gender,
      required this.number,
      required this.firstName,
      required this.secondName,
      required this.email,
      required this.wallet});

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      number: data["number"],
      firstName: data["firstName"],
      email: data["email"],
      wallet: data["wallet"],
      gender: data['gender'],
      secondName: data["secondName"],
    );
  }
  static Map<String, Object> toMap(UserModel userModel) {
    return {
      "firstName": userModel.firstName,
      "secondName": userModel.secondName,
      "email": userModel.email,
      "number": userModel.number,
      "wallet": userModel.wallet,
      "gender": userModel.gender,
    };
  }
}
