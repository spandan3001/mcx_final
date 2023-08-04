import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mcx_live/models/admin_model.dart';
import 'package:mcx_live/models/user_model.dart';

class AdminProvider extends ChangeNotifier {
  late AdminModel _adminModel;

  AdminModel getAdmin() {
    return _adminModel;
  }

  void getUserFromDB() {}

  void setUserToDB(AdminModel adminModel) {
    FirebaseFirestore.instance.collection("admin").doc(_adminModel.id).update(
          adminModel.toMap(adminModel),
        );
    _notifyAll();
  }

  void updateDB(Map<String, dynamic> data) {
    FirebaseFirestore.instance
        .collection("admin")
        .doc(_adminModel.id)
        .update(data);
    _notifyAll();
  }

  void setAdmin(AdminModel adminModel) {
    _adminModel = adminModel;
    _notifyAll();
  }

  String getEmail() {
    return _adminModel.email;
  }

  String? getImage() {
    return _adminModel.imageUrl;
  }

  String getAdminDocId() {
    return _adminModel.id;
  }

  void _notifyAll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
