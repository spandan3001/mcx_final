import 'package:cloud_firestore/cloud_firestore.dart';

import 'bid_price_model.dart';

class DataModel {
  final String id;
  final String token;
  final String lastTradedPrice;
  final String openPriceDay;
  final String highPriceDay;
  final String lowPriceDay;
  final String closePrice;
  final String upperCircuit;
  final String lowerCircuit;
  final String buy;
  final String sell;

  const DataModel({
    required this.token,
    required this.id,
    required this.lastTradedPrice,
    required this.openPriceDay,
    required this.highPriceDay,
    required this.closePrice,
    required this.lowerCircuit,
    required this.lowPriceDay,
    required this.upperCircuit,
    required this.sell,
    required this.buy,
  });

  factory DataModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    final BidPriceModel bidPriceModelSell =
        BidPriceModel.fromSnapshot(data['best_five_data'][5]);
    final BidPriceModel bidPriceModelBuy =
        BidPriceModel.fromSnapshot(data['best_five_data'][0]);
    return DataModel(
      id: document.id,
      token: data['token'],
      lastTradedPrice: data['last_traded_price'],
      openPriceDay: data['open_price_day'],
      highPriceDay: data['high_price_day'],
      closePrice: data['close_price'],
      lowerCircuit: data['lower_circuit'],
      lowPriceDay: data['low_price_day'],
      upperCircuit: data['upper_circuit'],
      sell: bidPriceModelSell.buySellPrice,
      buy: bidPriceModelBuy.buySellPrice,
    );
  }
}
