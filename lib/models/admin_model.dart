import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  final String id;
  final String name;
  final String email;
  final String number;

  const AdminModel({
    required this.id,
    required this.number,
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
    );
  }
}
