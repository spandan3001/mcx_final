import 'package:flutter/cupertino.dart';
import 'package:mcx_live/models/admin_model.dart';
import 'package:mcx_live/services/firestore_services.dart';

class AdminProvider extends ChangeNotifier {
  late AdminModel _adminModel;

  AdminModel getAdmin() {
    return _adminModel;
  }

  Future<void> getUserFromDB() async {
    await CloudService.adminCollection.doc(_adminModel.id).get().then((value) {
      _adminModel = AdminModel.fromSnapshot(value);
    });
    _notifyAll();
  }

  Future<void> setUserToDB(AdminModel adminModel) async {
    await CloudService.adminCollection.doc(_adminModel.id).update(
          adminModel.toMap(adminModel),
        );
    await getUserFromDB();
    _notifyAll();
  }

  Future<void> updateDB(Map<String, dynamic> data) async {
    await CloudService.adminCollection.doc(_adminModel.id).update(data);
    await getUserFromDB();
    _notifyAll();
  }

  void setAdmin(AdminModel adminModel) {
    _adminModel = adminModel;
    _notifyAll();
  }

  String getEmail() {
    return _adminModel.email;
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
