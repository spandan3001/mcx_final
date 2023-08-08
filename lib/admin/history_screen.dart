import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mcx_live/models/payment_model.dart';
import 'package:mcx_live/ui_screen.dart';
import 'package:mcx_live/utils/components/app_bar.dart';
import '../services/firestore_services.dart';
import 'custom_widgets/approved_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackGround(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar(
          title: "APPROVED",
          onTap: () {
            Navigator.pop(context);
          },
        ),
        body: StreamBuilder(
            stream: CloudService.paymentCollection.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blueGrey,
                  ),
                );
              } else {
                final messages = snapshot.data?.docs;
                List<ApprovedCardWidget> listReq = [];
                int count = 1;
                for (QueryDocumentSnapshot<Map<String, dynamic>> message
                    in messages!) {
                  PaymentModel paymentModel =
                      PaymentModel.fromSnapshot(message);

                  if (paymentModel.approved == true) {
                    listReq.add(
                      ApprovedCardWidget(
                        docId: message.id,
                        slNo: count++,
                        refNo: paymentModel.refId ?? "",
                        name: paymentModel.firstName,
                        email: paymentModel.email,
                        userId: paymentModel.id,
                        amount: paymentModel.amount,
                      ),
                    );
                  }
                }
                return ListView.builder(
                  itemCount: listReq.length,
                  itemBuilder: (BuildContext context, int index) {
                    return listReq[index];
                  },
                );
              }
            }),
      ),
    );
  }
}
