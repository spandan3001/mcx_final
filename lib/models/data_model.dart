import 'package:cloud_firestore/cloud_firestore.dart';

import '../six_moths_only/trade_symbol.dart';
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
    final String token = data['token'];
    final BidPriceModel bidPriceModelSell =
        BidPriceModel.fromSnapshot(data['best_five_data'][5]);
    final BidPriceModel bidPriceModelBuy =
        BidPriceModel.fromSnapshot(data['best_five_data'][0]);
    return DataModel(
      id: document.id,
      token: token.replaceAll('"', ''),
      lastTradedPrice: convertToDecimal(data['last_traded_price']),
      openPriceDay: convertToDecimal(data['open_price_day']),
      highPriceDay: convertToDecimal(data['high_price_day']),
      closePrice: convertToDecimal(data['close_price']),
      lowerCircuit: convertToDecimal(data['lower_circuit']),
      lowPriceDay: convertToDecimal(data['low_price_day']),
      upperCircuit: convertToDecimal(data['upper_circuit']),
      sell: convertToDecimal(bidPriceModelSell.buySellPrice),
      buy: convertToDecimal(bidPriceModelBuy.buySellPrice),
    );
  }

  static String getStringFromToken(String str) {
    final String? temp = tradeSymbol[str]?["symbol"];
    if (temp!.length > 8) {
      return temp.substring(0, ((temp.length) - 8)) ?? str;
    } else {
      return str;
    }
  }

  static String getExpiryFromToken(String str) =>
      tradeSymbol[str]?["expiry"] ?? str;

  static String convertToDecimal(String str) {
    if (str.length > 2) {
      return "${str.substring(0, str.length - 2)}.${str.substring(str.length - 2, str.length)}";
    } else {
      return str;
    }
  }
}
