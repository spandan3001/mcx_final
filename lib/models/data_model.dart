// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

import '../six_moths_only/trade_symbol.dart';

List<DataModel> dataModelFromJson(String str) =>
    List<DataModel>.from(json.decode(str).map((x) => DataModel.fromJson(x)));

String dataModelToJson(List<DataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataModel {
  String id;
  int subscriptionMode;
  int exchangeType;
  String token;
  String sequenceNumber;
  String exchangeTimestamp;
  String lastTradedPrice;
  String lastTradedQuantity;
  String avgTradedPrice;
  String volTraded;
  String totalBuyQuantity;
  String totalSellQuantity;
  String openPriceDay;
  String highPriceDay;
  String lowPriceDay;
  String closePrice;
  String lastTradedTimestamp;
  String openInterest;
  String openInterestChange;
  List<BestFiveDatum> bestFiveData;
  int v;

  DataModel({
    required this.id,
    required this.subscriptionMode,
    required this.exchangeType,
    required this.token,
    required this.sequenceNumber,
    required this.exchangeTimestamp,
    required this.lastTradedPrice,
    required this.lastTradedQuantity,
    required this.avgTradedPrice,
    required this.volTraded,
    required this.totalBuyQuantity,
    required this.totalSellQuantity,
    required this.openPriceDay,
    required this.highPriceDay,
    required this.lowPriceDay,
    required this.closePrice,
    required this.lastTradedTimestamp,
    required this.openInterest,
    required this.openInterestChange,
    required this.bestFiveData,
    required this.v,
  });

  static String getToken(String val) {
    return val.replaceAll('"', '');
  }

  factory DataModel.copyWithChanges(DataModel original, String newToken,
      List<BestFiveDatum> newBestFiveData) {
    return DataModel(
      id: original.id,
      subscriptionMode: original.subscriptionMode,
      exchangeType: original.exchangeType,
      token: newToken, // Change the token
      sequenceNumber: original.sequenceNumber,
      exchangeTimestamp: original.exchangeTimestamp,
      lastTradedPrice: original.lastTradedPrice,
      lastTradedQuantity: original.lastTradedQuantity,
      avgTradedPrice: original.avgTradedPrice,
      volTraded: original.volTraded,
      totalBuyQuantity: original.totalBuyQuantity,
      totalSellQuantity: original.totalSellQuantity,
      openPriceDay: original.openPriceDay,
      highPriceDay: original.highPriceDay,
      lowPriceDay: original.lowPriceDay,
      closePrice: original.closePrice,
      lastTradedTimestamp: original.lastTradedTimestamp,
      openInterest: original.openInterest,
      openInterestChange: original.openInterestChange,
      bestFiveData: newBestFiveData, // Change the list
      v: original.v,
    );
  }

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        id: json["_id"],
        subscriptionMode: json["subscription_mode"],
        exchangeType: json["exchange_type"],
        token: getToken(json["token"]),
        sequenceNumber: json["sequence_number"],
        exchangeTimestamp: json["exchange_timestamp"],
        lastTradedPrice: convertToDecimal(json["last_traded_price"]),
        lastTradedQuantity: json["last_traded_quantity"],
        avgTradedPrice: convertToDecimal(json["avg_traded_price"]),
        volTraded: json["vol_traded"],
        totalBuyQuantity: json["total_buy_quantity"],
        totalSellQuantity: json["total_sell_quantity"],
        openPriceDay: convertToDecimal(json["open_price_day"]),
        highPriceDay: convertToDecimal(json["high_price_day"]),
        lowPriceDay: convertToDecimal(json["low_price_day"]),
        closePrice: convertToDecimal(json["close_price"]),
        lastTradedTimestamp: json["last_traded_timestamp"],
        openInterest: json["open_interest"],
        openInterestChange: json["open_interest_change"],
        bestFiveData: List<BestFiveDatum>.from(
            json["best_five_data"].map((x) => BestFiveDatum.fromJson(x))),
        v: json["__v"],
      );

  static String getStringFromToken(String str) {
    final String? temp = tradeSymbol[str]?["symbol"];
    if (temp!.length > 2) {
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

  Map<String, dynamic> toJson() => {
        "_id": id,
        "subscription_mode": subscriptionMode,
        "exchange_type": exchangeType,
        "token": token,
        "sequence_number": sequenceNumber,
        "exchange_timestamp": exchangeTimestamp,
        "last_traded_price": lastTradedPrice,
        "last_traded_quantity": lastTradedQuantity,
        "avg_traded_price": avgTradedPrice,
        "vol_traded": volTraded,
        "total_buy_quantity": totalBuyQuantity,
        "total_sell_quantity": totalSellQuantity,
        "open_price_day": openPriceDay,
        "high_price_day": highPriceDay,
        "low_price_day": lowPriceDay,
        "close_price": closePrice,
        "last_traded_timestamp": lastTradedTimestamp,
        "open_interest": openInterest,
        "open_interest_change": openInterestChange,
        "best_five_data":
            List<dynamic>.from(bestFiveData.map((x) => x.toJson())),
        "__v": v,
      };
}

class BestFiveDatum {
  String buySellIndicator;
  String buySellQuantity;
  String buySellPrice;
  String buySellOrders;
  String id;

  BestFiveDatum({
    required this.buySellIndicator,
    required this.buySellQuantity,
    required this.buySellPrice,
    required this.buySellOrders,
    required this.id,
  });

  factory BestFiveDatum.fromJson(Map<String, dynamic> json) => BestFiveDatum(
        buySellIndicator: convertToDecimal(json["buy_sell_indicator"]),
        buySellQuantity: convertToDecimal(json["buy_sell_quantity"]),
        buySellPrice: convertToDecimal(json["buy_sell_price"]),
        buySellOrders: convertToDecimal(json["buy_sell_orders"]),
        id: json["_id"],
      );
  static String convertToDecimal(String str) {
    if (str.length > 2) {
      return "${str.substring(0, str.length - 2)}.${str.substring(str.length - 2, str.length)}";
    } else {
      return str;
    }
  }

  Map<String, dynamic> toJson() => {
        "buy_sell_indicator": buySellIndicator,
        "buy_sell_quantity": buySellQuantity,
        "buy_sell_price": buySellPrice,
        "buy_sell_orders": buySellOrders,
        "_id": id,
      };
}
