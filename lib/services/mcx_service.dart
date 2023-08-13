import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mcx_live/models/data_model.dart';
import 'package:mcx_live/services/firestore_services.dart';
import 'package:mcx_live/six_moths_only/trade_symbol.dart';

import '../models/order_model.dart';

class McxService {
  static Future<bool> placeOrder(
      {required String userId,
      required String userEmail,
      required String wallet,
      List<OrderModel>? orders,
      required String placedPoint,
      required String option,
      required String type,
      required String token}) async {
    if (checkConditions(wallet: wallet, orders: orders)) {
      await CloudService.orderCollection.add({
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
      // await CloudService.userCollection.doc(userId).update({
      //   'wallet': getDifference(
      //       placedPoint: placedPoint,
      //       option: option,
      //       token: token,
      //       wallet: wallet)
      // });
      return true;
    } else {
      return false;
    }
  }

  static bool checkConditions(
      {required String wallet, required List<OrderModel>? orders}) {
    double walletAmt = double.parse(wallet);

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

  static String getDifference(
      {required String option,
      required String placedPoint,
      required String token,
      required String wallet}) {
    String commodity = DataModel.getStringFromToken(token);
    return (double.parse(wallet) -
            (double.parse(option) *
                (double.parse(placedPoint) * price[commodity]!)))
        .toString();
  }

  static Map<double, double> lootLimitList = {
    10000: 1,
    20000: 1.25,
    40000: 1.5,
    70000: 2,
    100000: 2.5
  };
}
