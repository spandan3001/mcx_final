import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {super.key,
      required this.slNo,
      required this.refNo,
      required this.name,
      required this.email,
      required this.docId,
      required this.userId,
      required this.approvedDays});

  final int slNo;
  final String refNo;
  final String name;
  final String email;
  final String docId;
  final String userId;
  final int approvedDays;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.white10,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 60,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF5C249),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        "$slNo",
                        style: const TextStyle(
                          color: Color(0xFF16171D),
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Text(
                    refNo,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Name',
                        style: TextStyle(color: Colors.grey, fontSize: 22),
                      ),
                      const SizedBox(width: 36),
                      Expanded(
                        child: Text(
                          name,
                          softWrap: true,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      const Text(
                        'Email',
                        style: TextStyle(color: Colors.grey, fontSize: 22),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        child: Text(
                          email,
                          softWrap: true,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 21),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 37),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 130,
                    height: 68,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: ElevatedButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("payments")
                              .doc(docId)
                              .update(
                            {"approved": true},
                          );
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(userId)
                              .update(
                            {
                              "subscribed": true,
                              "start_time": FieldValue.serverTimestamp(),
                              'free': 10000000,
                            },
                          ).whenComplete(
                            () async {
                              var snapshot = await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(userId)
                                  .get();

                              UserModel userData =
                                  UserModel.fromSnapshot(snapshot);
                              // Timestamp start_time =
                              //     Timestamp.fromMillisecondsSinceEpoch(
                              //         userData.subscriptionStartTime);

                              // DateTime end_time = start_time.toDate().add(
                              //       Duration(
                              //         days: approvedDays,
                              //       ),
                              //     );
                              // FirebaseFirestore.instance
                              //     .collection("users")
                              //     .doc(userId)
                              //     .update(
                              //   {"end_time": end_time},
                              // );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF5C249),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                        child: const Text(
                          'Accept',
                          style: TextStyle(
                            color: Color(0xFF16171D),
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 50),
                  SizedBox(
                    width: 130,
                    height: 68,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: ElevatedButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("payments")
                              .doc(docId)
                              .delete();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF5C249),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                        child: const Text(
                          'Reject',
                          style: TextStyle(
                            color: Color(0xFF16171D),
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
