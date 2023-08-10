import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mcx_live/services/firestore_services.dart';

import '../models/order_model.dart';

class McxService {
  static Future<bool> placeOrder(
      {required String userId,
      required String userEmail,
      required String wallet,
      List<OrderModel>? orders,
      required String price,
      required String option,
      required String type,
      required String commodity}) async {
    if (checkConditions(wallet: wallet, orders: orders)) {
      await CloudService.orderCollection.add({
        "userId": userId,
        "email": userEmail,
        "placedPrice": price,
        "timeStamp": FieldValue.serverTimestamp(),
        "option": option,
        "commodity": commodity,
        "isActive": true,
        "type": type
      });
      return true;
    } else {
      return false;
    }
  }

  static bool checkConditions(
      {required String wallet, required List<OrderModel>? orders}) {
    double walletAmt = double.parse(wallet);

    double totalPercentage = 0.0;
    if (orders != null) {
      for (OrderModel order in orders) {
        double percentage =
            double.parse(order.option.substring(0, order.option.length - 1));
        totalPercentage += percentage;
      }
    }
    double loot = totalPercentage / 100;

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

  static Map<double, double> lootLimitList = {
    10000: 1,
    20000: 1.25,
    40000: 1.5,
    70000: 2,
    100000: 2.5
  };
}
