import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mcx_live/models/payment_model.dart';

import '../utils/color_constants.dart';
import 'custom_widgets/card_widget.dart';

class AddRemove extends StatefulWidget {
  const AddRemove({super.key});

  @override
  State<AddRemove> createState() => _AddRemoveState();
}

class _AddRemoveState extends State<AddRemove> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: kPrimaryBackgroundColor,
        title: const Text(
          'Add & Remove',
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
              List<CardWidget> listReq = [];
              int count = 1;
              for (QueryDocumentSnapshot<Map<String, dynamic>> message
                  in messages!) {
                PaymentModel paymentModel = PaymentModel.fromSnapshot(message);

                // if (paymentModel.approved == false) {
                //   listReq.add(
                //     CardWidget(
                //       docId: message.id,
                //       slNo: count++,
                //       refNo: paymentModel.ref_id,
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
