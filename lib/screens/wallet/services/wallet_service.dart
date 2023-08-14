import 'package:flutter/cupertino.dart';
import 'package:mcx_live/models/payment_model.dart';
import 'package:mcx_live/models/user_model.dart';
import 'package:mcx_live/screens/wallet/utils/enums.dart';
import 'package:mcx_live/services/firestore_services.dart';
import 'package:provider/provider.dart';
import '../../../provider_classes/user_details_provider.dart';
import '../utils/enter_referenceid.dart';

bool withdrawAmount(BuildContext context, String amount, UserModel userModel) {
  try {
    double currentBal = double.parse(userModel.wallet);
    double amt = double.parse(amount);
    if (currentBal < amt) {
      return false;
    } else {
      final data = PaymentModel.toMap(
        PaymentModel(
          firstName: userModel.firstName,
          secondName: userModel.secondName,
          approved: false,
          amount: "$amt",
          id: userModel.id,
          number: userModel.upiId ?? "",
          email: userModel.email,
          type: TypeOfSubmit.withdraw.name,
        ),
      );

      Provider.of<UserProvider>(context, listen: false)
          .updateDB({"wallet": "${currentBal - amt}"});
      CloudService.paymentCollection.add(data);
      return true;
    }
  } catch (ex) {
    return false;
  }
}

Future<bool> addAmount(
    BuildContext context, String amount, UserModel userModel) async {
  final result = await getRefInputDialog(
    context,
    title: "utr number",
    text: "please enter the utr number",
  );
  if (result!.$1) {
    try {
      final data = PaymentModel.toMap(PaymentModel(
          firstName: userModel.firstName,
          secondName: userModel.secondName,
          refId: result.$2,
          approved: false,
          amount: amount,
          id: userModel.id,
          number: userModel.upiId ?? "",
          email: userModel.email,
          type: TypeOfSubmit.add.name));
      CloudService.paymentCollection.add(data);
      return true;
    } catch (ex) {
      return false;
    }
  } else {
    return false;
  }
}
