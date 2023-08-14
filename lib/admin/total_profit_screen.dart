import 'package:flutter/material.dart';
import 'package:mcx_live/services/api/stream_controller.dart';
import 'package:mcx_live/ui_screen.dart';

import '../models/data_model.dart';
import '../models/order_model.dart';
import '../models/server_order_model.dart';
import '../services/firestore_services.dart';
import '../six_moths_only/trade_symbol.dart';
import '../utils/components/app_bar.dart';
import '../utils/components/circular_progress.dart';
import '../utils/google_font.dart';

class TotalProfitScreen extends StatelessWidget {
  const TotalProfitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackGround(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar(
          title: "Total Profit",
          onTap: () {
            Navigator.pop(context);
          },
        ),
        body: StreamBuilder(
          stream: CloudService.orderCollection.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<OrderModel> orderModelList = snapshot.data!.docs
                  .map((e) => OrderModel.fromSnapshot(e))
                  .toList();
              return StreamBuilder(
                  stream: OrderStreamController.stream,
                  builder: (context, serOrderSnaps) {
                    double amount;
                    Map<String, double> options;
                    if (serOrderSnaps.hasData) {
                      List<ServerOrderModel> svrOrderModels =
                          serOrderSnaps.data!;

                      (amount, options) =
                          getTotalAmt(svrOrderModels, orderModelList);
                      List<String> keys = options.keys.toList();

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                "Admin Profit : $amount",
                                style: SafeGoogleFont(
                                  'Sofia Pro',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: getColor(amount),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: ListView.builder(
                                itemCount: keys.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      "${keys[index]} : ${options[keys[index]]}",
                                      style: SafeGoogleFont(
                                        'Sofia Pro',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff1d3a6f),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      );
                    } else {
                      return const Loading();
                    }
                  });
            } else {
              return const Loading();
            }
          },
        ),
      ),
    );
  }

  double difference(String point, String token, String option) {
    String commodity = DataModel.getStringFromToken(token);

    double cur = double.parse(point);

    double quan = double.parse(option);
    return (cur * quan * price[commodity]!);
  }

  (double, Map<String, double>) getTotalAmt(
      List<ServerOrderModel> serOrders, List<OrderModel> orders) {
    double amount = 0.0;
    Map<String, double> options = {};

    for (ServerOrderModel serOrder in serOrders) {
      for (OrderModel order in orders) {
        if (options[DataModel.getStringFromToken(order.token)] != null) {
          options[DataModel.getStringFromToken(order.token)] =
              (options[DataModel.getStringFromToken(order.token)]! +
                  double.parse(order.option));
        } else {
          options[DataModel.getStringFromToken(order.token)] = 0.0;
        }
        if (serOrder.orderId == order.id) {
          amount += difference(serOrder.diffPoint, order.token, order.option) +
              double.parse(order.amount);
          break;
        }
      }
    }
    return (amount.roundToDouble(), options);
  }

  Color getColor(double amount) {
    return amount < 0 ? Colors.red : Colors.green;
  }
}
