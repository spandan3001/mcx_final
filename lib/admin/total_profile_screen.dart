import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/firestore_services.dart';
import '../utils/components/app_bar.dart';
import '../utils/components/circular_progress.dart';

class TotalProfitScreen extends StatelessWidget {
  const TotalProfitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<UserModel> listUserModel = [];
    return Scaffold(
      appBar: appBar(
        title: "Total Profit",
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: StreamBuilder(
        stream: CloudService.userCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int count = 1;
            listUserModel = snapshot.data!.docs
                .map((e) => UserModel.fromSnapshot(e))
                .toList();

            return Column(
              children: [],
            );
          } else {
            return const Loading();
          }
        },
      ),
    );
  }
}
