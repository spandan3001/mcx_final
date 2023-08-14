// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

List<PostModel> orderModelFromJson(String str) =>
    List<PostModel>.from(json.decode(str).map((x) => PostModel.fromJson(x)));

class PostModel {
  String point;
  String orderId;
  String userId;
  String token;
  String status;
  String type;

  PostModel({
    required this.point,
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
      );

  static Map<String, String> toJson(PostModel postModel) => {
        "price": postModel.point,
        "type": postModel.type,
        "token": postModel.token,
        "status": postModel.status,
        "userid": postModel.userId,
        "orderid": postModel.orderId,
      };
}
