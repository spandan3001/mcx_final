import 'dart:async';
import 'package:mcx_live/models/server_order_model.dart';

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
