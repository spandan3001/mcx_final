import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mcx_live/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  late UserModel _userModel;

  UserModel getUser() {
    return _userModel;
  }

  void getUserFromDB() {}

  void setUserToDB(UserModel userModel) {
    FirebaseFirestore.instance.collection("users").doc(_userModel.id).update(
          UserModel.toMap(userModel),
        );
    _notifyAll();
  }

  void updateDB(Map<String, dynamic> data) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(_userModel.id)
        .update(data);
    _notifyAll();
  }

  void setUser(UserModel userModel) {
    _userModel = userModel;
    _notifyAll();
  }

  String getEmail() {
    return _userModel.email;
  }

  void _notifyAll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}