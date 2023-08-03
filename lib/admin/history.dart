import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mcx_live/models/payment_model.dart';

import '../utils/color_constants.dart';
import 'custom_widgets/approved_card.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: kPrimaryBackgroundColor,
        title: const Text(
          'History',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("payments").snapshots(),
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
                PaymentModel paymentModel = PaymentModel.fromSnapshot(message);

                // if (paymentModel.approved == true) {
                //   listReq.add(
                //     ApprovedCardWidget(
                //       docId: message.id,
                //       slNo: count++,
                //       refNo: paymentModel.refId,
                //       name: paymentModel.name,
                //       email: paymentModel.email,
                //       userId: paymentModel.id,
                //       approvedDays: paymentModel.approvedDays,
                //     ),
                //   );
                // }
              }
              return ListView.builder(
                itemCount: listReq.length,
                itemBuilder: (BuildContext context, int index) {
                  return listReq[index];
                },
              );
            }
          }),
    );
  }
}
