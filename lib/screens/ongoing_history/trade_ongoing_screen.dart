import 'package:flutter/material.dart';
import 'package:mcx_live/services/firestore_services.dart';
import 'package:mcx_live/six_moths_only/trade_symbol.dart';
import 'package:mcx_live/utils/components/circular_progress.dart';
import '../../models/data_model.dart';
import '../../models/order_model.dart';
import '../../utils/google_font.dart';

class TradeOngoing extends StatefulWidget {
  const TradeOngoing({super.key});

  @override
  State<TradeOngoing> createState() => _TradeOngoingState();
}

class _TradeOngoingState extends State<TradeOngoing> {
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

            return ListView.builder(
                itemCount: orderModelList.length,
                itemBuilder: (context, index) => TradeOngoingCard(
                      placedPoint: orderModelList[index].placedPoint,
                      type: orderModelList[index].type,
                      commodity: orderModelList[index].commodity,
                    ));
          } else {
            return const Loading();
          }
        });
  }
}

class TradeOngoingCard extends StatefulWidget {
  const TradeOngoingCard({
    super.key,
    required this.placedPoint,
    required this.type,
    required this.commodity,
  });
  final String placedPoint;
  final String type;
  final String commodity;

  @override
  State<TradeOngoingCard> createState() => _TradeOngoingCardState();
}

class _TradeOngoingCardState extends State<TradeOngoingCard> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.sizeOf(context).width / baseWidth;
    double fFem = fem * 0.97;
    return GestureDetector(
      onTap: () {},
      child: StreamBuilder(
        stream: CloudService.mcxCollection
            .where("token", isEqualTo: widget.commodity)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            DataModel dataModel =
                DataModel.fromSnapshot(snapshot.data!.docs.first);
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
                          color: getTextColor(dataModel.buy),
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
                                DataModel.getStringFromToken(widget.commodity),
                                style: SafeGoogleFont(
                                  'Sofia Pro',
                                  fontSize: fFem * 18,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff1d3a6f),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                DataModel.getExpiryFromToken(widget.commodity),
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
                                "₹${getDifferenceInPrice(dataModel.buy, DataModel.getStringFromToken(widget.commodity))}",
                                style: SafeGoogleFont(
                                  'Sofia Pro',
                                  fontSize: fFem * 18,
                                  fontWeight: FontWeight.bold,
                                  color: getTextColor(dataModel.buy),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "LTP:₹${dataModel.lastTradedPrice}",
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
                                  // Text(
                                  //   widget.placedPoint,
                                  //   style: TextStyle(
                                  //       color: getTextColor(dataModel.buy)),
                                  // ),
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

  String getDifferenceInPrice(String actualPoints, String commodity) {
    double placed = double.parse(widget.placedPoint);
    double actual = double.parse(actualPoints);

    return ((actual - placed) * price[commodity]!).toString();
  }
}
