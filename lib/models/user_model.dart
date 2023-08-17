import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String firstName;
  final String? secondName;
  final String email;
  final String number;
  final String gender;
  final String wallet;
  final String referCode;
  final String? refererUId;
  final String? imageUrl;
  final String? upiId;
  final bool depositForRefer;

  const UserModel(
      {required this.id,
      required this.referCode,
      required this.depositForRefer,
      required this.gender,
      this.imageUrl,
      this.upiId,
      this.refererUId,
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
        upiId: data["upiId"],
        gender: data['gender'],
        imageUrl: data['imageUrl'],
        secondName: data["secondName"],
        referCode: data["referCode"],
        refererUId: data["refererUid"],
        depositForRefer: data['depositForRefer']);
  }
  static Map<String, Object> toMap(UserModel userModel) {
    return {
      "firstName": userModel.firstName,
      "secondName": userModel.secondName ?? "",
      "email": userModel.email,
      "number": userModel.number,
      "wallet": userModel.wallet,
      "gender": userModel.gender,
      "referCode": userModel.referCode,
      "refererUId": userModel.refererUId ?? "",
      "imageUrl": userModel.imageUrl ?? "",
      "upiId": userModel.upiId ?? "",
      'depositForRefer': userModel.depositForRefer
    };
  }
}
