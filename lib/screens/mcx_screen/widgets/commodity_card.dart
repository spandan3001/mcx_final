import 'package:flutter/material.dart';
import '../../../models/data_model.dart';
import '../../../utils/google_font.dart';

class CommodityCard extends StatefulWidget {
  const CommodityCard({super.key, required this.dataModel});

  final DataModel dataModel;

  @override
  State<CommodityCard> createState() => _CommodityCardState();
}

void test() {
  int oldX, newX;
  Color color;
  oldX = newX = 10;
  newX = getX();
  color = newX <= oldX ? color = Colors.red : Colors.green;
}

int getX() {
  return 20;
}

class _CommodityCardState extends State<CommodityCard> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.sizeOf(context).width / baseWidth;
    double fFem = fem * 0.97;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                    color: Colors.green,
                    offset: Offset(-7, 0),
                    blurRadius: 6,
                    spreadRadius: -6)
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        "GOLD",
                        style: SafeGoogleFont(
                          'Sofia Pro',
                          fontSize: fFem * 12,
                          color: const Color(0xff1d3a6f),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "22Aug",
                        style: SafeGoogleFont(
                          'Sofia Pro',
                          fontSize: fFem * 12,
                          color: const Color(0xff1d3a6f),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.dataModel.lastTradedPrice,
                    style: SafeGoogleFont(
                      'Sofia Pro',
                      fontSize: fFem * 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff1d3a6f),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "0.75",
                        style: SafeGoogleFont(
                          'Sofia Pro',
                          fontSize: fFem * 12,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "(0.34%)",
                        style: SafeGoogleFont(
                          'Sofia Pro',
                          fontSize: fFem * 12,
                          color: const Color(0xff1d3a6f),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.dataModel.openPriceDay,
                          style: TextStyle(fontSize: 16),
                        ),
                        const VerticalDivider(
                          width: 25,
                          thickness: 1,
                          indent: 2,
                          endIndent: 1,
                          color: Colors.black,
                        ),
                        Text(
                          widget.dataModel.highPriceDay,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text("O:", style: TextStyle(fontSize: 12.5)),
                          Text(widget.dataModel.openPriceDay,
                              style: const TextStyle(fontSize: 12.5)),
                        ],
                      ),
                      const SizedBox(width: 5),
                      Row(
                        children: [
                          const Text("H:", style: TextStyle(fontSize: 12.5)),
                          Text(widget.dataModel.highPriceDay,
                              style: const TextStyle(fontSize: 12.5)),
                        ],
                      ),
                      const SizedBox(width: 5),
                      Row(
                        children: [
                          const Text("L:", style: TextStyle(fontSize: 12.5)),
                          Text(widget.dataModel.lowPriceDay,
                              style: const TextStyle(fontSize: 12.5)),
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
  }
}

// Row(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Column(
// children: [
// const Text("uppr"),
// const Divider(
// color: Colors.black,
// height: 10,
// ),
// Text(widget.dataModel.upperCircuit),
// ],
// ),
// Column(
// children: [
// const Text("lwr"),
// const Divider(
// color: Colors.black,
// height: 10,
// ),
// Text(widget.dataModel.lowerCircuit),
// ],
// ),
// ],
// )
