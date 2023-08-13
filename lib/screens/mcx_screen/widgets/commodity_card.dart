import 'package:flutter/material.dart';
import '../../../models/data_model.dart';
import '../../../utils/components/show_pop_down/show_pop_down_screen.dart';
import '../../../utils/google_font.dart';

class CommodityCard extends StatelessWidget {
  const CommodityCard({
    super.key,
    required this.dataModel,
    required this.colorSet,
  });

  final DataModel dataModel;
  final ColorModel colorSet;

  @override
  Widget build(BuildContext context) {
    String actualBuyPoint = dataModel.bestFiveData[5].buySellPrice;
    String actualSellPoint = dataModel.bestFiveData[0].buySellPrice;
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
              token: dataModel.token,
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
                        dataModel.lastTradedPrice, dataModel.closePrice)),
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
                            dataModel.token,
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
                            dataModel.token,
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
                    Row(
                      children: [
                        Text(
                          dataModel.lastTradedPrice,
                          style: SafeGoogleFont(
                            'Sofia Pro',
                            fontSize: fFem * 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff1d3a6f),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "(${getDifferenceInPoints(dataModel.lastTradedPrice, dataModel.closePrice)})",
                          style: SafeGoogleFont(
                            'Sofia Pro',
                            fontSize: fFem * 12,
                            color: getColor(getDifferenceInPoints(
                                dataModel.lastTradedPrice,
                                dataModel.closePrice)),
                            fontWeight: FontWeight.bold,
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
                      height: fem * 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            color: colorSet.sellColor,
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              actualSellPoint,
                              style: SafeGoogleFont(
                                'Sofia Pro',
                                fontSize: fFem * 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const VerticalDivider(
                            width: 25,
                            thickness: 1,
                            indent: 2,
                            endIndent: 1,
                            color: Colors.black,
                          ),
                          Container(
                            color: colorSet.buyColor,
                            child: Text(
                              actualBuyPoint,
                              style: SafeGoogleFont(
                                'Sofia Pro',
                                fontSize: fFem * 16,
                                fontWeight: FontWeight.bold,
                              ),
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
                              dataModel.openPriceDay,
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
                            Text(dataModel.highPriceDay,
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
                              dataModel.lowPriceDay,
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

class ColorModel {
  ColorModel({required this.buyColor, required this.sellColor});
  final Color buyColor;
  final Color sellColor;

  static Map<String, Color> toMap(ColorModel model) => {
        'buy': model.buyColor,
        'sell': model.sellColor,
      };
}
