import 'package:flutter/material.dart';
import 'package:mcx_live/models/order_model.dart';
import 'package:mcx_live/services/firestore_services.dart';
import 'package:mcx_live/utils/components/circular_progress.dart';

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
                      closePrice: orderModelList[index].closedPrice ?? "",
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
      required this.closePrice});
  final String placedPrice;
  final String type;
  final String closePrice;

  @override
  State<TradeHistoryCard> createState() => _TradeHistoryCardState();
}

class _TradeHistoryCardState extends State<TradeHistoryCard> {
  @override
  Widget build(BuildContext context) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.placedPrice,
                style: TextStyle(color: getTextColor(widget.closePrice)),
              ),
              Text(
                widget.closePrice,
              ),
              Text(widget.type),
            ],
          ),
        ),
      ),
    );
  }

  Color getTextColor(String actualPrice) {
    double placed = double.parse(widget.placedPrice);
    double actual = double.parse(actualPrice);

    return placed <= actual ? Colors.green : Colors.red;
  }
}
