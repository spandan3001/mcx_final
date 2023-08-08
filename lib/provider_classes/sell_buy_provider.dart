import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mcx_live/models/admin_model.dart';
import 'package:mcx_live/models/user_model.dart';

class AdminProvider extends ChangeNotifier {
  void addToSell() {}

  void _notifyAll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
