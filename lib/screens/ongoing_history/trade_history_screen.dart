import 'package:flutter/material.dart';
import 'package:mcx_live/models/order_model.dart';
import 'package:mcx_live/services/firestore_services.dart';
import 'package:mcx_live/utils/components/circular_progress.dart';

import '../../models/data_model.dart';
import '../../six_moths_only/trade_symbol.dart';
import '../../utils/google_font.dart';

class TradeHistory extends StatefulWidget {
  const TradeHistory({super.key});

  @override
  State<TradeHistory> createState() => _TradeHistoryState();
}

class _TradeHistoryState extends State<TradeHistory> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: CloudService.orderCollection
            .where("isActive", isEqualTo: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<OrderModel> orderModelList = snapshot.data!.docs
                .map((e) => OrderModel.fromSnapshot(e))
                .toList();

            return ListView.builder(
                itemCount: orderModelList.length,
                itemBuilder: (context, index) => TradeHistoryCard(
                      placedPrice: orderModelList[index].placedPoint,
                      type: orderModelList[index].type,
                      closePrice: orderModelList[index].closedPoint,
                      amount: orderModelList[index].amount,
                      token: orderModelList[index].token,
                    ));
          } else {
            return const Loading();
          }
        });
  }
}

class TradeHistoryCard extends StatefulWidget {
  const TradeHistoryCard(
      {super.key,
      required this.placedPrice,
      required this.type,
      required this.closePrice,
      required this.amount,
      required this.token});
  final String placedPrice;
  final String type;
  final String token;
  final String closePrice;
  final String amount;

  @override
  State<TradeHistoryCard> createState() => _TradeHistoryCardState();
}

class _TradeHistoryCardState extends State<TradeHistoryCard> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.sizeOf(context).width / baseWidth;
    double fFem = fem * 0.97;
    String amount = getDifferenceInPrice(widget.closePrice, widget.placedPrice,
        DataModel.getStringFromToken(widget.token));
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
                    color: getTextColor(widget.closePrice),
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
                          "₹$amount",
                          style: SafeGoogleFont(
                            'Sofia Pro',
                            fontSize: fFem * 18,
                            fontWeight: FontWeight.bold,
                            color: getTextColor(amount),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  String getDifferenceInPrice(
      String placedPoints, String actualPoints, String commodity) {
    double placed = double.parse(placedPoints);
    double actual = double.parse(actualPoints);
    return ((placed - actual) * price[commodity]!).roundToDouble().toString();
  }

  Color getTextColor(String actualPrice) {
    double actual = double.parse(actualPrice);
    return actual >= 0 ? Colors.green : Colors.red;
  }
}
