import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mcx_live/services/firestore_services.dart';
import 'package:mcx_live/ui_screen.dart';
import 'package:mcx_live/utils/components/app_bar.dart';
import '../screens/wallet/utils/enums.dart';
import 'custom_widgets/card_widget.dart';
import '../models/payment_model.dart';

class AddRemoveScreen extends StatefulWidget {
  const AddRemoveScreen({super.key});

  @override
  State<AddRemoveScreen> createState() => _AddRemoveScreenState();
}

class _AddRemoveScreenState extends State<AddRemoveScreen> {
  @override
  Widget build(BuildContext context) {
    return BackGround(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar(
            title: "REQUESTS",
            onTap: () {
              Navigator.pop(context);
            }),
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
                List<CardWidget> listReq = [];
                int count = 1;
                for (QueryDocumentSnapshot<Map<String, dynamic>> message
                    in messages!) {
                  PaymentModel paymentModel =
                      PaymentModel.fromSnapshot(message);

                  if (paymentModel.approved == false &&
                      paymentModel.type == TypeOfSubmit.add.name) {
                    listReq.add(
                      CardWidget(
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
