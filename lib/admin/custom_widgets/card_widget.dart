import 'package:flutter/material.dart';
import 'package:mcx_live/admin/custom_widgets/show_dialog_return.dart';
import 'package:mcx_live/services/firestore_services.dart';
import 'package:mcx_live/utils/color_constants.dart';
import 'package:provider/provider.dart';
import '../../models/user_model.dart';
import '../../provider_classes/user_details_provider.dart';
import '../../utils/google_font.dart';
import 'card_widget_button.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {super.key,
      required this.slNo,
      required this.phNO,
      required this.refNo,
      required this.name,
      required this.email,
      required this.docId,
      required this.userId,
      required this.amount});

  final int slNo;
  final String refNo;
  final String name;
  final String email;
  final String docId;
  final String userId;
  final String amount;
  final String phNO;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      begin: Alignment(0, -1),
                      end: Alignment(0, 1),
                      colors: <Color>[kGradient1, kGradient2],
                      stops: <double>[0, 5],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      slNo.toString(),
                      style: SafeGoogleFont(
                        'Sofia Pro',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
                Text(
                  // fGV (143:98)
                  refNo,
                  style: SafeGoogleFont(
                    'Sofia Pro',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Name:',
                          style: SafeGoogleFont(
                            'Sofia Pro',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff564c4c),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Email:',
                          style: SafeGoogleFont(
                            'Sofia Pro',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff564c4c),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Amount:',
                          style: SafeGoogleFont(
                            'Sofia Pro',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff564c4c),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'UPI ID:',
                          style: SafeGoogleFont(
                            'Sofia Pro',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff564c4c),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          name,
                          style: SafeGoogleFont(
                            'Sofia Pro',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff000000),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.5,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              email,
                              maxLines: 1,
                              style: SafeGoogleFont(
                                'Sofia Pro',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          amount,
                          style: SafeGoogleFont(
                            'Sofia Pro',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff000000),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          phNO, //this is upi ID oki
                          style: SafeGoogleFont(
                            'Sofia Pro',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff000000),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CardButton(
                  name: 'Accept',
                  onPressed: () async {
                    final bool? result = await confirm(context);
                    if (result!) {
                      accept(context);
                    }
                  },
                ),
                CardButton(
                  name: 'Reject',
                  onPressed: () async {
                    final bool? result = await confirm(context);
                    if (result != null && result) {
                      reject();
                    }
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> confirm(BuildContext context) async {
    return await showDialogReturn(context,
        text: "Are you sure?", title: "Confirm");
  }

  Future<void> accept(BuildContext context) async {
    UserModel userModel =
        Provider.of<UserProvider>(context, listen: false).getUser();
    double curAmt = double.parse(userModel.wallet);
    double addAmt = double.parse(amount);
    CloudService.paymentCollection.doc(docId).update({"approved": true});

    if (userModel.depositForRefer) {
      if (userModel.refererUId != null) {
        await Provider.of<UserProvider>(context, listen: false)
            .updateDB({"wallet": (curAmt + addAmt).toString()});
      }
    } else {
      updateReferUser(userModel.refererUId);
      await Provider.of<UserProvider>(context, listen: false).updateDB(
          {"wallet": (curAmt + addAmt).toString(), "depositForRefer": true});
    }
  }

  Future<void> updateReferUser(String? id) async {
    if (id != null) {
      UserModel userModel = UserModel.fromSnapshot(
          await CloudService.userCollection.doc(id).get());
      double curAmt = double.parse(userModel.wallet);
      double addAmt = 200.0 + curAmt;
      CloudService.userCollection.doc(id).update({"wallet": addAmt.toString()});
    }
  }

  void reject() {
    CloudService.paymentCollection.doc(docId).delete();
  }
}
