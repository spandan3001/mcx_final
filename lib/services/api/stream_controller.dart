import 'dart:async';
import '../../models/data_model_1.dart';

class MyStreamController {
  static final StreamController<List<DataModel>> _controller =
      StreamController<List<DataModel>>.broadcast();

  static Stream<List<DataModel>> get stream => _controller.stream;

  static void sendData(List<DataModel> data) {
    _controller.sink.add(data);
  }

  static void dispose() {
    _controller.close();
  }
}
