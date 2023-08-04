import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  final String id;
  final String name;
  final String email;
  final String number;
  final String? upiId;
  final String? imageUrl;

  const AdminModel({
    required this.id,
    required this.number,
    this.upiId,
    this.imageUrl,
    required this.name,
    required this.email,
  });

  factory AdminModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return AdminModel(
        id: document.id,
        number: data["number"],
        name: data["name"],
        email: data["email"],
        upiId: data["upiId"],
        imageUrl: data["imageUrl"]);
  }

  Map<String, dynamic> toMap(AdminModel adminModel) => {
        "name": adminModel.name,
        "email": adminModel.email,
        "number": adminModel.number,
        "imageUrl": adminModel.imageUrl ?? "",
        "upiId": adminModel.upiId ?? ""
      };
}
