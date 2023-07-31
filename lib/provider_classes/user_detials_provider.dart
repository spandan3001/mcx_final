import 'package:flutter/cupertino.dart';
import 'package:mcx_live/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  late UserModel userModel;

  void getUser() {}

  void getUserFromDB() {}

  void setUserToDB(UserModel userModel) {}

  void setUser(UserModel userModel) {
    this.userModel = userModel;
    notifyListeners();
  }
}
