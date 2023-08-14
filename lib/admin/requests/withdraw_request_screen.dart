import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mcx_live/services/firestore_services.dart';
import 'package:mcx_live/ui_screen.dart';
import 'package:mcx_live/utils/components/app_bar.dart';

import '../../models/payment_model.dart';
import '../../screens/wallet/utils/enums.dart';
import '../custom_widgets/card_widget.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
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
            stream: CloudService.paymentCollection
                .where('approved', isEqualTo: false)
                .where('type', isEqualTo: TypeOfSubmit.withdraw.name)
                .snapshots(),
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
                  listReq.add(
                    CardWidget(
                      docId: message.id,
                      slNo: count++,
                      refNo: paymentModel.refId ?? "",
                      name: paymentModel.firstName,
                      email: paymentModel.email,
                      userId: paymentModel.id,
                      amount: paymentModel.amount,
                      phNO: paymentModel.number,
                    ),
                  );
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
