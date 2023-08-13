import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:mcx_live/services/api/stream_controller.dart';
import 'package:mcx_live/services/firestore_services.dart';

import '../../models/data_model.dart';

const apiUrl = "http://65.1.168.46:3000/";
const putGetUrl = "http://65.1.168.46:3000/mcx/";

final url = Uri.parse(apiUrl);

late Timer timerForMcx;

Future<http.Response> doPost(Map<String, String> data) {
  return http.post(Uri.parse(putGetUrl), headers: data);
}

void getOrders() async {
  final url = Uri.parse(putGetUrl);
  timerForMcx = Timer.periodic(
    const Duration(seconds: 1),
    (timer) async {
      final http.Response response = await http.get(url);
      if (response.statusCode == 200) {}
    },
  );
}

void getData() async {
  Timer.periodic(
    const Duration(seconds: 1),
    (timer) async {
      final http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        final List<DataModel> dataModels = dataModelFromJson(response.body);
        // final DataModel? platinum = await getPlatinum(dataModels);
        // if (platinum != null) {
        //   dataModels.add(platinum);
        // }
        MyStreamController.sendData(dataModels);
      }
    },
  );
}

Future<DataModel?> getPlatinum(List<DataModel> dataModels) async {
  final data = await getPlatinumDb();
  if (data != null) {
    final List<DataModel> platinumS = dataModels
        .where((element) => element.token.contains(data["token"]))
        .toList();

    if (platinumS.isNotEmpty) {
      final DataModel platinum = platinumS.first;
      List<BestFiveDatum> bestData = platinum.bestFiveData;
      bestData[0].buySellPrice = data['sellPoint'];
      bestData[5].buySellPrice = data['buyPoint'];
      final newPlatinum =
          DataModel.copyWithChanges(platinum, "000000", bestData);
      return newPlatinum;
    } else {
      return null;
    }
  }
  return null;
}

Future<Map<String, dynamic>?> getPlatinumDb() async {
  final snapshot = await CloudService.platinumDoc.get();
  return snapshot.data();
}
