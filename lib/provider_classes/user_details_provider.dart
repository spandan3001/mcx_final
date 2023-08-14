import 'package:flutter/cupertino.dart';
import 'package:mcx_live/models/user_model.dart';
import 'package:mcx_live/services/firestore_services.dart';

class UserProvider extends ChangeNotifier {
  late UserModel _userModel;

  UserModel getUser() {
    return _userModel;
  }

  Future<void> getUserFromDB() async {
    await CloudService.userCollection.doc(_userModel.id).get().then((value) {
      _userModel = UserModel.fromSnapshot(value);
    });
    _notifyAll();
  }

  Future<void> setUserToDB(UserModel userModel) async {
    await CloudService.userCollection.doc(_userModel.id).update(
          UserModel.toMap(userModel),
        );
    await getUserFromDB();
    _notifyAll();
  }

  Future<void> updateDB(Map<String, dynamic> data) async {
    await CloudService.userCollection.doc(_userModel.id).update(data);
    await getUserFromDB();
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
