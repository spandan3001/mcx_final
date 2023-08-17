import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mcx_live/models/post_model.dart';
import 'package:mcx_live/services/firestore_services.dart';
import 'package:provider/provider.dart';

import '../models/data_model.dart';
import '../models/order_model.dart';
import '../provider_classes/user_details_provider.dart';
import '../six_moths_only/trade_symbol.dart';
import 'api/api.dart';

class McxService {
  static Future<bool> placeOrder(BuildContext context,
      {required String userId,
      required String userEmail,
      required String wallet,
      List<OrderModel>? orders,
      required String placedPoint,
      required String option,
      required String type,
      required String token}) async {
    if (checkConditions(wallet: wallet, orders: orders)) {
      final orderDoc = await CloudService.orderCollection.add({
        "userId": userId,
        "email": userEmail,
        "placedPoint": placedPoint,
        "timeStamp": FieldValue.serverTimestamp(),
        "option": option,
        "closedPoint": "0",
        "amount": "0",
        "token": token,
        "isActive": true,
        "type": type
      });
      double currentAmt = double.parse(placedPoint) *
          double.parse(option) *
          price[DataModel.getStringFromToken(token)]!;
      double userAmount =
          (double.parse(wallet) - ((currentAmt * 1750) / 10000000));
      Provider.of<UserProvider>(context, listen: false).updateDB(
        {"wallet": (double.parse(wallet) - userAmount).toStringAsFixed(2)},
      );
      OrderModel orderModel = OrderModel.fromSnapshot(await orderDoc.get());
      PostModel postModel = PostModel(
          point: placedPoint,
          userId: userId,
          orderId: orderModel.id,
          status: "open",
          type: type,
          token: token,
          bet: orderModel.option,
          wallet: wallet);

      final resp = await doPost(PostModel.toJson(postModel));
      if (resp.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static bool checkConditions(
      {required String wallet, required List<OrderModel>? orders}) {
    double walletAmt = double.parse(wallet);
    if (walletAmt < 500) {
      return false;
    }

    double loot = 0.0;
    if (orders != null) {
      for (OrderModel order in orders) {
        double percentage = double.parse(order.option);
        loot += percentage;
      }
    }

    if (walletAmt < 1000) {
      if (loot < 0.7) {
        return true;
      } else {
        return false;
      }
    } else if (walletAmt < 20000) {
      if (loot < 1.25) {
        return true;
      } else {
        return false;
      }
    } else if (walletAmt < 40000) {
      if (loot < 1.5) {
        return true;
      } else {
        return false;
      }
    } else if (walletAmt < 70000) {
      if (loot < 2) {
        return true;
      } else {
        return false;
      }
    } else if (walletAmt < 100000) {
      if (loot < 2.5) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  // static String getDifference(
  //     {required String option,
  //     required String placedPoint,
  //     required String token,
  //     required String wallet}) {
  //   String commodity = DataModel.getStringFromToken(token);
  //   return (double.parse(wallet) -
  //           (double.parse(option) *
  //               (double.parse(placedPoint) * price[commodity]!)))
  //       .toString();
  // }

  // static Map<double, double> lootLimitList = {
  //   10000: 1,
  //   20000: 1.25,
  //   40000: 1.5,
  //   70000: 2,
  //   100000: 2.5
  // };
}
