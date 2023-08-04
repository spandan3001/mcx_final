import 'package:flutter/cupertino.dart';
import 'package:mcx_live/models/payment_model.dart';
import 'package:mcx_live/models/user_model.dart';
import 'package:mcx_live/screens/wallet/utils/enums.dart';
import 'package:mcx_live/services/firestore_services.dart';

import '../utils/enter_referenceid.dart';

bool withdrawAmount(String amount, UserModel userModel) {
  try {
    double currentBal = double.parse(userModel.wallet);
    double amt = double.parse(amount);
    if (currentBal < amt) {
      return false;
    } else {
      final data = PaymentModel.toMap(PaymentModel(
          firstName: userModel.firstName,
          refId: "xxx",
          approved: false,
          amount: amount,
          id: userModel.id,
          number: userModel.number,
          email: userModel.email,
          type: TypeOfSubmit.withdraw.name));
      CloudService.paymentCollection.add(data);
      return true;
    }
  } catch (ex) {
    return false;
  }
}

bool addAmount(BuildContext context, String amount, UserModel userModel) {
  TextEditingController controller = TextEditingController();
  getRefInputDialog(context, title: '', controller: controller);
  try {
    final data = PaymentModel.toMap(PaymentModel(
        firstName: userModel.firstName,
        refId: controller.text,
        approved: false,
        amount: amount,
        id: userModel.id,
        number: userModel.number,
        email: userModel.email,
        type: TypeOfSubmit.add.name));
    CloudService.paymentCollection.add(data);
    return true;
  } catch (ex) {
    return false;
  }
}
