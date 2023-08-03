import 'package:mcx_live/models/payment_model.dart';
import 'package:mcx_live/models/user_model.dart';
import 'package:mcx_live/screens/wallet/utils/enums.dart';
import 'package:mcx_live/services/firestore_servies.dart';

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
          type: TypeOfSubmit.withdraw));
      CloudService.paymentCollection.add(data);
      return true;
    }
  } catch (ex) {
    return false;
  }
}

bool addAmount(String amount, UserModel userModel) {
  try {
    final data = PaymentModel.toMap(PaymentModel(
        firstName: userModel.firstName,
        refId: "xxx",
        approved: false,
        amount: amount,
        id: userModel.id,
        number: userModel.number,
        email: userModel.email,
        type: TypeOfSubmit.add));
    CloudService.paymentCollection.add(data);
    return true;
  } catch (ex) {
    return false;
  }
}
