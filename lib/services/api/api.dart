import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:mcx_live/services/api/stream_controller.dart';

import '../../models/data_model_1.dart';

const apiUrl = "http://65.1.168.46:3000/";

final url = Uri.parse(apiUrl);

void getData() async {
  Timer.periodic(
    const Duration(seconds: 1),
    (timer) async {
      final http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        final List<DataModel> dataModels = dataModelFromJson(response.body);
        MyStreamController.sendData(dataModels);
      }
    },
  );
}
