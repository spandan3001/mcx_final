import 'package:flutter/material.dart';
import 'package:mcx_live/utils/color_constants.dart';
import '../../utils/google_font.dart';

class ApprovedCardWidget extends StatelessWidget {
  const ApprovedCardWidget(
      {super.key,
      required this.slNo,
      required this.phNo,
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
  final String phNo;

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
                          'PhNo:',
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          email,
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
                          phNo,
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
