// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

List<ServerOrderModel> orderModelFromJson(String str) =>
    List<ServerOrderModel>.from(
        json.decode(str).map((x) => ServerOrderModel.fromJson(x)));

class ServerOrderModel {
  String id;
  String orderId;
  String userId;
  String diffPoint;
  String status;

  ServerOrderModel({
    required this.id,
    required this.userId,
    required this.orderId,
    required this.diffPoint,
    required this.status,
  });

  factory ServerOrderModel.fromJson(Map<String, dynamic> json) =>
      ServerOrderModel(
          id: json["_id"],
          userId: json["userid"],
          orderId: json["orderid"],
          diffPoint: convertToDecimal(json["final"].toString()),
          status: json["status"]);

  static String convertToDecimal(String str) {
    if (str.length > 2) {
      return "${str.substring(0, str.length - 2)}.${str.substring(str.length - 2, str.length)}";
    } else {
      return str;
    }
  }
}
