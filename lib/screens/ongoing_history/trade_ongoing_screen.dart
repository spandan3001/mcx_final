import 'package:flutter/material.dart';
import 'package:mcx_live/models/server_order_model.dart';
import 'package:mcx_live/provider_classes/user_details_provider.dart';
import 'package:mcx_live/services/api/stream_controller.dart';
import 'package:mcx_live/services/firestore_services.dart';
import 'package:mcx_live/six_moths_only/trade_symbol.dart';
import 'package:mcx_live/utils/components/circular_progress.dart';
import 'package:provider/provider.dart';
import '../../models/data_model.dart';
import '../../models/order_model.dart';
import '../../models/post_model.dart';
import '../../models/user_model.dart';
import '../../services/api/api.dart';
import '../../utils/components/show_dialog.dart';
import '../../utils/google_font.dart';

class TradeOngoing extends StatefulWidget {
  const TradeOngoing({super.key});

  @override
  State<TradeOngoing> createState() => _TradeOngoingState();
}

class _TradeOngoingState extends State<TradeOngoing>
    with AutomaticKeepAliveClientMixin<TradeOngoing> {
  String amount = "";
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
      stream: CloudService.orderCollection
          .where("isActive", isEqualTo: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<OrderModel> orderModelList = snapshot.data!.docs
              .map((e) => OrderModel.fromSnapshot(e))
              .toList();
          return StreamBuilder(
              stream: OrderStreamController.stream,
              builder: (context, serOrderSnaps) {
                if (serOrderSnaps.hasData) {
                  UserModel userModel =
                      Provider.of<UserProvider>(context, listen: false)
                          .getUser();
                  List<ServerOrderModel> svrOrderModels = serOrderSnaps.data!;
                  amount =
                      getTotalAmt(svrOrderModels, orderModelList, userModel.id)
                          .roundToDouble()
                          .toString();
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "Wallet :${double.parse(userModel.wallet) - double.parse(amount)} ",
                          style: SafeGoogleFont(
                            'Sofia Pro',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff1d3a6f),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: orderModelList.length,
                            itemBuilder: (context, index) {
                              List<ServerOrderModel> singleSer = [];
                              for (ServerOrderModel ele in svrOrderModels) {
                                if (ele.orderId
                                    .contains(orderModelList[index].id)) {
                                  singleSer.add(ele);
                                }
                              }
                              return TradeOngoingCard(
                                orderModel: orderModelList[index],
                                serverOrderModels: singleSer[0],
                                userModel: userModel,
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
    );
  }

  double difference(String point, String token, String option) {
    String commodity = DataModel.getStringFromToken(token);

    double cur = double.parse(point);

    double quan = double.parse(option);
    return (cur * quan * price[commodity]!);
  }

  double getTotalAmt(List<ServerOrderModel> serOrders, List<OrderModel> orders,
      String userId) {
    double amount = 0.0;
    for (ServerOrderModel serOrder in serOrders) {
      print(serOrder.diffPoint);
      for (OrderModel order in orders) {
        if (serOrder.orderId == order.id && order.userId == userId) {
          amount += difference(serOrder.diffPoint, order.token, order.option);
          break;
        }
      }
    }
    return amount;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class TradeOngoingCard extends StatelessWidget {
  const TradeOngoingCard({
    super.key,
    required this.orderModel,
    required this.serverOrderModels,
    required this.userModel,
  });
  final OrderModel orderModel;
  final ServerOrderModel serverOrderModels;
  final UserModel userModel;

  // late String buyPoint;
  //
  // late String sellPoint;
  //
  // late String pointOfType;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.sizeOf(context).width / baseWidth;
    double fFem = fem * 0.97;
    String commodity = DataModel.getStringFromToken(orderModel.token);
    String ongoingAmount =
        "${(price[commodity]! * double.parse(orderModel.option) * double.parse(serverOrderModels.diffPoint)).roundToDouble()}";
    return GestureDetector(
      onTap: () async {
        final result = await showAlertDialog(context,
            title: "Confirm", text: "want to close?", optionNo: true);
        if (result != null) {
          if (result) {
            double amountInDouble = double.parse(ongoingAmount);
            String userAmount;
            if (amountInDouble > 0) {
              userAmount = (amountInDouble * 0.8).toString();
            } else {
              userAmount = ongoingAmount;
            }
            PostModel postModel = PostModel(
                point: orderModel.placedPoint,
                userId: userModel.id,
                orderId: orderModel.id,
                status: "closed",
                type: orderModel.type,
                token: orderModel.token);

            final resp = await doPost(PostModel.toJson(postModel));
            if (resp.statusCode == 200) {
              double closedPoint = double.parse(orderModel.placedPoint) +
                  double.parse(serverOrderModels.diffPoint);
              CloudService.orderCollection.doc(orderModel.id).update(
                {
                  "amount": userAmount,
                  "closedPoint": closedPoint.toString(),
                  "isActive": false,
                },
              );
            }

            Provider.of<UserProvider>(context, listen: false).updateDB({
              "wallet":
                  (double.parse(userModel.wallet) - double.parse(userAmount))
                      .toString()
            });
          }
        }
      },
      child: Padding(
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
                    color: getTextColor(),
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
                          commodity,
                          style: SafeGoogleFont(
                            'Sofia Pro',
                            fontSize: fFem * 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff1d3a6f),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          DataModel.getExpiryFromToken(orderModel.token),
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
                      " ${orderModel.option} Qty (${orderModel.type.toUpperCase()})",
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
                          "${price[commodity]! * double.parse(serverOrderModels.diffPoint)}",
                          style: SafeGoogleFont(
                            'Sofia Pro',
                            fontSize: fFem * 18,
                            fontWeight: FontWeight.bold,
                            color: getTextColor(),
                          ),
                        ),
                        const SizedBox(width: 5),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color getTextColor() {
    double actual = double.parse(serverOrderModels.diffPoint);

    return actual >= 0 ? Colors.green : Colors.red;
  }
}
