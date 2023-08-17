import 'package:mcx_live/provider_classes/platinum_provider.dart';

import '../../models/data_model.dart';

DataModel? getPlatinum(List<DataModel> dataModels) {
  final data = getPlatinumDb();
  final List<DataModel> platinumS = dataModels
      .where((element) => element.token.contains(data["token"]!))
      .toList();
  if (platinumS.isNotEmpty) {
    final DataModel platinum = platinumS.first;

    return createPlatinum(platinum, data);
  } else {
    return null;
  }
}

DataModel createPlatinum(DataModel origin, Map<String, String> data) {
  List<BestFiveDatum> bestData = origin.bestFiveData;
  double valueS = double.parse(bestData[0].buySellPrice) +
      double.parse(data['point']!).roundToDouble();
  double valueB = double.parse(bestData[5].buySellPrice) +
      double.parse(data['point']!).roundToDouble();

  double openPriceDay =
      double.parse(origin.openPriceDay) + double.parse(data['point']!);
  double highPriceDay =
      double.parse(origin.highPriceDay) + double.parse(data['point']!);
  double lowPriceDay =
      double.parse(origin.lowPriceDay) + double.parse(data['point']!);
  double closePrice =
      double.parse(origin.closePrice) + double.parse(data['point']!);
  double lastTradedPrice =
      double.parse(origin.lastTradedPrice) + double.parse(data['point']!);
  List<BestFiveDatum> bestFiveData = List.generate(10, (index) {
    String tempBuySell = "";
    if (index == 0) {
      tempBuySell = valueS.toString();
    } else if (index == 5) {
      tempBuySell = valueB.toString();
    } else {
      tempBuySell = bestData[index].buySellPrice;
    }
    return BestFiveDatum(
        buySellIndicator: bestData[index].buySellIndicator,
        buySellQuantity: bestData[index].buySellQuantity,
        buySellPrice: tempBuySell,
        buySellOrders: bestData[index].buySellOrders,
        id: bestData[index].id);
  });
  return DataModel(
      id: "platinum",
      subscriptionMode: origin.subscriptionMode,
      exchangeType: origin.exchangeType,
      token: "000000",
      sequenceNumber: origin.sequenceNumber,
      exchangeTimestamp: origin.exchangeTimestamp,
      lastTradedPrice: lastTradedPrice.toString(),
      lastTradedQuantity: origin.lastTradedQuantity,
      avgTradedPrice: origin.avgTradedPrice,
      volTraded: origin.volTraded,
      totalBuyQuantity: origin.totalBuyQuantity,
      totalSellQuantity: origin.totalSellQuantity,
      openPriceDay: openPriceDay.toString(),
      highPriceDay: highPriceDay.toString(),
      lowPriceDay: lowPriceDay.toString(),
      closePrice: closePrice.toString(),
      lastTradedTimestamp: origin.lastTradedTimestamp,
      openInterest: origin.openInterest,
      openInterestChange: origin.openInterestChange,
      bestFiveData: bestFiveData,
      v: origin.v);
}

Map<String, String> getPlatinumDb() {
  Map<String, String> data = {
    'point': PlatinumProvider.point,
    'token': PlatinumProvider.token
  };
  return data;
}
