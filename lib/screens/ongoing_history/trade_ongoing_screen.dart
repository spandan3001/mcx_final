import 'package:flutter/material.dart';
import 'package:mcx_live/screens/ongoing_history/utils/pop_down_ongoing.dart';
import 'package:mcx_live/services/api/stream_controller.dart';
import 'package:mcx_live/services/firestore_services.dart';
import 'package:mcx_live/six_moths_only/trade_symbol.dart';
import 'package:mcx_live/utils/components/circular_progress.dart';
import '../../models/data_model_1.dart';
import '../../models/order_model.dart';
import '../../utils/components/custom_radio_button.dart';
import '../../utils/components/show_dialog.dart';
import '../../utils/google_font.dart';

class TradeOngoing extends StatefulWidget {
  const TradeOngoing({super.key});

  @override
  State<TradeOngoing> createState() => _TradeOngoingState();
}

class _TradeOngoingState extends State<TradeOngoing> {
  DataModel? oldData;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: CloudService.orderCollection
            .where("isActive", isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<OrderModel> orderModelList = snapshot.data!.docs
                .map((e) => OrderModel.fromSnapshot(e))
                .toList();
            return Column(
              children: [
                StreamBuilder(
                    stream: MyStreamController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<DataModel> dataModels = snapshot.data!;
                        String buyPrice = "";
                        String sellPrice = "";
                        String priceOfType = "";
                        double amount = 0.0;
                        for (OrderModel order in orderModelList) {
                          order.placedPoint;
                          List<DataModel> dataModels = snapshot.data!
                              .where((element) =>
                                  element.token.contains(order.token))
                              .toList();
                          if (dataModels.isNotEmpty) {
                            DataModel dataModel = dataModels[0];

                            buyPrice = dataModel.bestFiveData[5].buySellPrice;
                            sellPrice = dataModel.bestFiveData[0].buySellPrice;
                            if (order.type == BuyORSell.buy.name) {
                              priceOfType = buyPrice;
                            } else {
                              priceOfType = sellPrice;
                            }
                            amount += difference(
                                priceOfType, order.placedPoint, order.token);
                          }
                        }
                        return Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "Wallet :$amount ",
                            style: SafeGoogleFont(
                              'Sofia Pro',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff1d3a6f),
                            ),
                          ),
                        );
                      } else {
                        return const Loading();
                      }
                    }),
                Expanded(
                  child: ListView.builder(
                      itemCount: orderModelList.length,
                      itemBuilder: (context, index) => TradeOngoingCard(
                            placedPoint: orderModelList[index].placedPoint,
                            type: orderModelList[index].type,
                            token: orderModelList[index].token,
                            orderId: orderModelList[index].id,
                          )),
                ),
              ],
            );
          } else {
            return const Loading();
          }
        });
  }

  double difference(String actual, String ordered, String token) {
    String commodity = DataModel.getStringFromToken(token);

    double x = double.parse(actual);
    double y = double.parse(ordered);
    return ((x - y) * price[commodity]!).roundToDouble();
  }
}

class TradeOngoingCard extends StatefulWidget {
  const TradeOngoingCard({
    super.key,
    required this.placedPoint,
    required this.type,
    required this.token,
    required this.orderId,
  });
  final String placedPoint;
  final String type;
  final String token;
  final String orderId;

  @override
  State<TradeOngoingCard> createState() => _TradeOngoingCardState();
}

class _TradeOngoingCardState extends State<TradeOngoingCard> {
  DataModel? oldData;

  late String buyPoint;
  late String sellPoint;
  late String pointOfType;
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.sizeOf(context).width / baseWidth;
    double fFem = fem * 0.97;
    return GestureDetector(
      onTap: () async {
        final result = await showAlertDialog(context,
            title: "Confirm", text: "want to close?", optionNo: true);
        if (result != null) {
          if (result) {
            String amount = getDifferenceInPrice(widget.placedPoint,
                pointOfType, DataModel.getStringFromToken(widget.token));
            CloudService.orderCollection
                .doc(widget.orderId)
                .update({"amount": amount, "closedPoint": pointOfType});
          }
        }
      },
      child: StreamBuilder(
        stream: MyStreamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DataModel> dataModels = snapshot.data!
                .where((element) => element.token.contains(widget.token))
                .toList();
            DataModel dataModel;
            if (dataModels.isNotEmpty) {
              dataModel = dataModels[0];
            } else {
              dataModel = (oldData != null) ? oldData! : dataModels.first;
            }
            oldData = dataModel;
            buyPoint = dataModel.bestFiveData[5].buySellPrice;
            sellPoint = dataModel.bestFiveData[0].buySellPrice;
            if (widget.type == BuyORSell.buy.name) {
              pointOfType = buyPoint;
            } else {
              pointOfType = sellPoint;
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                elevation: 2,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: getTextColor(pointOfType),
                          offset: const Offset(-7, 0),
                          blurRadius: 4,
                          spreadRadius: -6)
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                DataModel.getStringFromToken(widget.token),
                                style: SafeGoogleFont(
                                  'Sofia Pro',
                                  fontSize: fFem * 18,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff1d3a6f),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                DataModel.getExpiryFromToken(widget.token),
                                style: SafeGoogleFont(
                                  'Sofia Pro',
                                  fontSize: fFem * 18,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff1d3a6f),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "?? Qty (${widget.type.toUpperCase().substring(0, 1)})",
                            style: SafeGoogleFont(
                              'Sofia Pro',
                              fontSize: fFem * 14,
                              color: const Color(0xff1d3a6f),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "₹${getDifferenceInPrice(widget.placedPoint, pointOfType, DataModel.getStringFromToken(widget.token))}",
                                style: SafeGoogleFont(
                                  'Sofia Pro',
                                  fontSize: fFem * 18,
                                  fontWeight: FontWeight.bold,
                                  color: getTextColor(pointOfType),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "LTP:${dataModel.lastTradedPrice}",
                                    style: SafeGoogleFont(
                                      'Sofia Pro',
                                      fontSize: fFem * 14,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "(-0.26%)",
                                    style: SafeGoogleFont(
                                      'Sofia Pro',
                                      fontSize: fFem * 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Loading();
          }
        },
      ),
    );
  }

  Color getTextColor(String actualPrice) {
    double placed = double.parse(widget.placedPoint);
    double actual = double.parse(actualPrice);

    return placed <= actual ? Colors.green : Colors.red;
  }

  String getDifference(String actualPoints) {
    double placed = double.parse(widget.placedPoint);
    double actual = double.parse(actualPoints);

    return (actual - placed).toString();
  }

  String getDifferenceInPrice(
      String placedPoints, String actualPoints, String commodity) {
    double placed = double.parse(placedPoints);
    double actual = double.parse(actualPoints);

    return ((actual - placed) * price[commodity]!).roundToDouble().toString();
  }
}
