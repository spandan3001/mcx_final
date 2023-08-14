import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:mcx_live/services/api/platinum.dart';
import 'package:mcx_live/services/api/stream_controller.dart';
import 'package:mcx_live/services/firestore_services.dart';
import 'package:mcx_live/six_moths_only/trade_symbol.dart';

import '../../models/data_model.dart';
import '../../models/order_model.dart';
import '../../models/server_order_model.dart';

const apiUrl = "http://65.1.168.46:3000/";
const putGetUrl = "http://65.1.168.46:3000/mcx/";

final url = Uri.parse(apiUrl);

late Timer timerForMcx;
late Timer timerForOrders;

Future<http.Response> doPost(Map<String, String> data) {
  return http.post(Uri.parse(putGetUrl), headers: data);
}

void getOrders() async {
  OrderStreamController.initState();
  try {
    final url = Uri.parse(putGetUrl);
    timerForOrders = Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        final http.Response response = await http.get(url);
        if (response.statusCode == 200) {
          final List<ServerOrderModel> serverOrderModels =
              orderModelFromJson(response.body);
          OrderStreamController.sendData(serverOrderModels);
        }
      },
    );
  } catch (ex) {
    print(ex.toString());
  }
}

void getData() {
  McxStreamController.initState();
  timerForMcx = Timer.periodic(
    const Duration(seconds: 1),
    (timer) async {
      try {
        final http.Response response = await http.get(url);
        if (response.statusCode == 200) {
          final List<DataModel> dataModels = dataModelFromJson(response.body);
          final DataModel? platinum = getPlatinum(dataModels);
          if (platinum != null) {
            dataModels.add(platinum);
          }
          McxStreamController.sendData(dataModels);
        }
      } catch (ex) {
        print(ex.toString());
      }
    },
  );
}

Future<void> updateHistoryOrders() async {
  List<ServerOrderModel> serverOrderModels = [];
  try {
    final url = Uri.parse(putGetUrl);
    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      serverOrderModels = orderModelFromJson(response.body);
    }
  } catch (ex) {
    print(ex.toString());
  }
  final snapshot = await CloudService.orderCollection.get();
  final List<OrderModel> orders =
      snapshot.docs.map((e) => OrderModel.fromSnapshot(e)).toList();
  for (ServerOrderModel serOrder in serverOrderModels) {
    bool add = false;
    String docId = "";
    String token = "";
    double closedPoint = 0.0;
    double option = 0.0;
    for (OrderModel order in orders) {
      if (serOrder.orderId == order.id && serOrder.status == "inactive") {
        add = true;
        docId = order.id;
        token = order.token;
        closedPoint =
            double.parse(serOrder.diffPoint) + double.parse(order.placedPoint);
        option = double.parse(order.option);
      }
    }
    if (add) {
      double amount =
          price[DataModel.getStringFromToken(token)]! * option * closedPoint;
      CloudService.orderCollection.doc(docId).update({
        'isActive': false,
        'closedPoint': closedPoint.toString(),
        'amount': amount.toString(),
      });
    }
  }
}
