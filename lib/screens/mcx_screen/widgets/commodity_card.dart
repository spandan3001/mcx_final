import 'package:flutter/material.dart';
import '../../../models/data_model_1.dart';
import '../../../utils/components/show_pop_down/show_pop_down_screen.dart';
import '../../../utils/google_font.dart';

class CommodityCard extends StatefulWidget {
  const CommodityCard({
    super.key,
    required this.dataModel,
  });

  final DataModel dataModel;

  @override
  State<CommodityCard> createState() => _CommodityCardState();
}

class _CommodityCardState extends State<CommodityCard> {
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

  @override
  Widget build(BuildContext context) {
    //print(widget.commodity);
    double baseWidth = 360;
    double w = MediaQuery.sizeOf(context).width;
    double fem = w / baseWidth;
    double fFem = fem * 0.97;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return PopDownSheetForTrade(
              token: widget.dataModel.token,
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 5,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: getColor(getDifferenceInPoints(
                        widget.dataModel.lastTradedPrice,
                        widget.dataModel.closePrice)),
                    offset: const Offset(-7, 0),
                    blurRadius: 4,
                    spreadRadius: -6)
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          DataModel.getStringFromToken(
                            widget.dataModel.token,
                          ),
                          style: SafeGoogleFont(
                            'Sofia Pro',
                            fontSize: fFem * 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff1d3a6f),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          DataModel.getExpiryFromToken(
                            widget.dataModel.token,
                          ).substring(0, 5),
                          style: SafeGoogleFont(
                            'Sofia Pro',
                            fontSize: fFem * 12,
                            fontWeight: FontWeight.bold,
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
                    Text(
                      getDifferenceInPoints(widget.dataModel.lastTradedPrice,
                          widget.dataModel.closePrice),
                      style: SafeGoogleFont(
                        'Sofia Pro',
                        fontSize: fFem * 12,
                        color: getColor(getDifferenceInPoints(
                            widget.dataModel.lastTradedPrice,
                            widget.dataModel.closePrice)),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: fFem * 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.dataModel.bestFiveData[0].buySellPrice,
                            style: SafeGoogleFont(
                              'Sofia Pro',
                              fontSize: fFem * 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const VerticalDivider(
                            width: 25,
                            thickness: 1,
                            indent: 2,
                            endIndent: 1,
                            color: Colors.black,
                          ),
                          Text(
                            widget.dataModel.bestFiveData[5].buySellPrice,
                            style: SafeGoogleFont(
                              'Sofia Pro',
                              fontSize: fFem * 16,
                              fontWeight: FontWeight.bold,
                            ),
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
                            Text(
                              "O:",
                              style: SafeGoogleFont(
                                'Sofia Pro',
                                fontSize: fFem * 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.dataModel.openPriceDay,
                              style: SafeGoogleFont(
                                'Sofia Pro',
                                fontSize: fFem * 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 5),
                        Row(
                          children: [
                            Text("H:",
                                style: SafeGoogleFont(
                                  'Sofia Pro',
                                  fontSize: fFem * 12,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text(widget.dataModel.highPriceDay,
                                style: SafeGoogleFont(
                                  'Sofia Pro',
                                  fontSize: fFem * 12,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                        const SizedBox(width: 5),
                        Row(
                          children: [
                            Text("L:",
                                style: SafeGoogleFont(
                                  'Sofia Pro',
                                  fontSize: fFem * 12,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text(
                              widget.dataModel.lowPriceDay,
                              style: SafeGoogleFont(
                                'Sofia Pro',
                                fontSize: fFem * 12,
                                fontWeight: FontWeight.bold,
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
      ),
    );
  }

  String getDifferenceInPoints(String actualPoints, String closePoints) {
    double close = double.parse(closePoints);
    double actual = double.parse(actualPoints);

    return (close - actual).roundToDouble().toString();
  }

  Color getColor(String change) {
    double changePrice = double.parse(change);
    return (changePrice <= 0) ? Colors.red : Colors.green;
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
