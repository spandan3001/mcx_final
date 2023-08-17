import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mcx_live/services/firestore_services.dart';
import 'package:mcx_live/utils/components/app_bar.dart';

import '../models/user_model.dart';
import '../utils/color_constants.dart';
import '../utils/components/circular_progress.dart';
import '../utils/google_font.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  List<UserModel> listUserModel = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: "Users",
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: CloudService.userCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int count = 1;
            listUserModel = snapshot.data!.docs
                .map((e) => UserModel.fromSnapshot(e))
                .toList();
            return ListView.builder(
                itemCount: listUserModel.length,
                itemBuilder: (context, index) {
                  UserModel userModel = listUserModel[index];
                  return UserCard(
                      slNo: count++,
                      referNo: userModel.referCode,
                      name: "${userModel.firstName} ${userModel.secondName}",
                      email: userModel.email,
                      amount: userModel.wallet);
                });
          } else {
            return const Loading();
          }
        },
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard(
      {super.key,
      required this.slNo,
      required this.referNo,
      required this.name,
      required this.email,
      required this.amount});

  final int slNo;
  final String referNo;
  final String name;
  final String email;
  final String amount;

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
                  referNo,
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
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
