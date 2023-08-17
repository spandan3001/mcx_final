// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

import 'package:mcx_live/six_moths_only/trade_symbol.dart';

import 'data_model.dart';

List<PostModel> orderModelFromJson(String str) =>
    List<PostModel>.from(json.decode(str).map((x) => PostModel.fromJson(x)));

class PostModel {
  String point;
  String orderId;
  String userId;
  String token;
  String status;
  String type;
  String wallet;
  String bet;

  PostModel({
    required this.point,
    required this.bet,
    required this.wallet,
    required this.userId,
    required this.orderId,
    required this.status,
    required this.type,
    required this.token,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        point: json["price"],
        userId: json["userid"],
        orderId: json["orderid"],
        status: json["status"],
        type: json["type"],
        token: json["token"],
        bet: json["bet"],
        wallet: json["wallet"],
      );

  static Map<String, String> toJson(PostModel postModel) => {
        "price": walletToServer(postModel.point),
        "type": postModel.type,
        "token": '"${postModel.token}"',
        "status": postModel.status,
        "userid": postModel.userId,
        "orderid": postModel.orderId,
        "bet": betToServer(postModel.token, postModel.bet),
        "wallet": walletToServer(postModel.wallet),
      };

  static String walletToServer(String wallet) {
    return (double.parse(wallet) * 100).toString();
  }

  static String betToServer(String token, String option) {
    return (price[DataModel.getStringFromToken(token)]! * double.parse(option))
        .toString();
  }
}
