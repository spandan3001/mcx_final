import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mcx_live/models/server_order_model.dart';
import 'package:mcx_live/provider_classes/platinum_provider.dart';
import 'package:mcx_live/services/firestore_services.dart';

import '../../models/data_model.dart';

class McxStreamController {
  static late StreamController<List<DataModel>> _controller;

  static void initState() {
    _controller = StreamController<List<DataModel>>.broadcast();
  }

  static Stream<List<DataModel>> get stream => _controller.stream;

  static void sendData(List<DataModel> data) {
    _controller.sink.add(data);
  }

  static void dispose() {
    _controller.close();
  }
}

class OrderStreamController {
  static late StreamController<List<ServerOrderModel>> _controller;

  static void initState() {
    _controller = StreamController<List<ServerOrderModel>>.broadcast();
  }

  static Stream<List<ServerOrderModel>> get stream => _controller.stream;

  static void sendData(List<ServerOrderModel> data) {
    _controller.sink.add(data);
  }

  static void dispose() {
    _controller.close();
  }
}

void listenToStream() {
  CloudService.platinumDoc.snapshots().listen(
    (snapshot) {
      final data = snapshot.data();
      PlatinumProvider.token = data?['token'];
      PlatinumProvider.point = data?['point'];
      print(data);
    },
  );
}
