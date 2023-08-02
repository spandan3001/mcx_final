import 'package:flutter/material.dart';

import '../utils/text_style.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double fFem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WALLET',
          textAlign: TextAlign.center,
          style: SafeGoogleFont(
            'Poppins',
            fontSize: 25 * fFem,
            fontWeight: FontWeight.w600,
            height: 1.5 * fFem / fem,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar:
          Image.asset("assets/line_chart.png", fit: BoxFit.fill),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding:
                EdgeInsets.fromLTRB(16 * fem, 33 * fem, 17 * fem, 45 * fem),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(
                      27 * fem, 20 * fem, 32 * fem, 20 * fem),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffe5e7eb)),
                    borderRadius: BorderRadius.circular(16 * fem),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Total amount:',
                        style: SafeGoogleFont(
                          'Sofia Pro',
                          fontSize: 21 * fFem,
                          fontWeight: FontWeight.w400,
                          height: 1.5 * fFem / fem,
                          letterSpacing: 0.3000000119 * fem,
                          color: const Color(0xff6b7280),
                        ),
                      ),
                      const SizedBox(width: 5),
                      RichText(
                        textAlign: TextAlign.right,
                        text: TextSpan(
                          style: SafeGoogleFont('Sofia Pro',
                              fontSize: 18 * fFem,
                              fontWeight: FontWeight.w400,
                              height: 1.3999999364 * fFem / fem,
                              letterSpacing: 0.3000000119 * fem,
                              color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'T',
                              style: SafeGoogleFont(
                                'ITF Rupee',
                                fontSize: 18 * fFem,
                                fontWeight: FontWeight.w400,
                                height: 1.3999999364 * fFem / fem,
                                letterSpacing: 0.3000000119 * fem,
                              ),
                            ),
                            const TextSpan(
                              text: '11,510.00',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      16 * fem, 16 * fem, 16 * fem, 15.5 * fem),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffe5e7eb)),
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(16 * fem),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // tittleGsB (143:22)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 16 * fem),
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Enter amount:',
                              style: SafeGoogleFont(
                                'Sofia Pro',
                                fontSize: 12 * fFem,
                                fontWeight: FontWeight.w400,
                                height: 1.5 * fFem / fem,
                                letterSpacing: 0.3000000119 * fem,
                                color: const Color(0xff6b7280),
                              ),
                            ),
                            RichText(
                              // nameL6M (143:24)
                              textAlign: TextAlign.right,
                              text: TextSpan(
                                style: SafeGoogleFont(
                                  'Sofia Pro',
                                  fontSize: 12 * fFem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5 * fFem / fem,
                                  letterSpacing: 0.3000000119 * fem,
                                  color: const Color(0xff6b7280),
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'Top up fee ',
                                  ),
                                  TextSpan(
                                    text: '₹',
                                    style: SafeGoogleFont(
                                      'ITF Rupee',
                                      fontSize: 12 * fFem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5 * fFem / fem,
                                      letterSpacing: 0.3000000119 * fem,
                                      color: const Color(0xff6b7280),
                                    ),
                                  ),
                                  const TextSpan(
                                    text: '300.0',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // usdUbs (143:25)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 40 * fem, 0.5 * fem),
                            width: 43 * fem,
                            height: 32 * fem,
                            decoration: BoxDecoration(
                              color: const Color(0xfff9fafb),
                              borderRadius: BorderRadius.circular(8 * fem),
                            ),
                            child: Center(
                              child: Text(
                                'IND',
                                style: SafeGoogleFont(
                                  'Roboto',
                                  fontSize: 16 * fFem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5 * fFem / fem,
                                  letterSpacing: 0.3000000119 * fem,
                                  color: const Color(0xff6b7280),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            '2,256',
                            style: SafeGoogleFont(
                              'Roboto',
                              fontSize: 24 * fFem,
                              fontWeight: FontWeight.w700,
                              height: 1.2999999523 * fFem / fem,
                              letterSpacing: -0.200000003 * fem,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                ///done
                const SizedBox(height: 50),
                SizedBox(
                  width: 327 * fem,
                  height: 40 * fem,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // amountVPF (143:14)
                        width: 92 * fem,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xfff9fafb),
                          borderRadius: BorderRadius.circular(12 * fem),
                        ),
                        child: Center(
                          child: Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: SafeGoogleFont(
                                  'ITF Rupee',
                                  fontSize: 14 * fFem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5 * fFem / fem,
                                  letterSpacing: 0.3000000119 * fem,
                                  color: const Color(0xff1d3a6f),
                                ),
                                children: [
                                  const TextSpan(
                                    text: '₹',
                                  ),
                                  TextSpan(
                                    text: '1500.00',
                                    style: SafeGoogleFont(
                                      'Sofia Pro',
                                      fontSize: 14 * fFem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5 * fFem / fem,
                                      letterSpacing: 0.3000000119 * fem,
                                      color: const Color(0xff1d3a6f),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        // amountRAR (143:16)
                        width: 95 * fem,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xfff9fafb),
                          borderRadius: BorderRadius.circular(12 * fem),
                        ),
                        child: Center(
                          child: Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: SafeGoogleFont(
                                  'Roboto',
                                  fontSize: 14 * fFem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5 * fFem / fem,
                                  letterSpacing: 0.3000000119 * fem,
                                  color: const Color(0xff1d3a6f),
                                ),
                                children: [
                                  TextSpan(
                                    text: '₹',
                                    style: SafeGoogleFont(
                                      'ITF Rupee',
                                      fontSize: 14 * fFem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5 * fFem / fem,
                                      letterSpacing: 0.3000000119 * fem,
                                      color: const Color(0xff1d3a6f),
                                    ),
                                  ),
                                  TextSpan(
                                    text: '3000.00',
                                    style: SafeGoogleFont(
                                      'Sofia Pro',
                                      fontSize: 14 * fFem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5 * fFem / fem,
                                      letterSpacing: 0.3000000119 * fem,
                                      color: const Color(0xff1d3a6f),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        // amountJNd (143:18)
                        width: 96 * fem,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xff0faeff),
                          borderRadius: BorderRadius.circular(12 * fem),
                        ),
                        child: Center(
                          child: Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: SafeGoogleFont(
                                  'Roboto',
                                  fontSize: 14 * fFem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5 * fFem / fem,
                                  letterSpacing: 0.3000000119 * fem,
                                  color: const Color(0xffffffff),
                                ),
                                children: [
                                  TextSpan(
                                    text: '₹',
                                    style: SafeGoogleFont(
                                      'ITF Rupee',
                                      fontSize: 14 * fFem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5 * fFem / fem,
                                      letterSpacing: 0.3000000119 * fem,
                                      color: const Color(0xffffffff),
                                    ),
                                  ),
                                  TextSpan(
                                    text: '6000.00',
                                    style: SafeGoogleFont(
                                      'Sofia Pro',
                                      fontSize: 14 * fFem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5 * fFem / fem,
                                      letterSpacing: 0.3000000119 * fem,
                                      color: const Color(0xffffffff),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  width: 327 * fem,
                  height: 56 * fem,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16 * fem),
                    gradient: const LinearGradient(
                      begin: Alignment(0, -1),
                      end: Alignment(0, 1),
                      colors: <Color>[Color(0xff12c1fc), Color(0xff0994fd)],
                      stops: <double>[0, 1],
                    ),
                  ),
                  child: Center(
                    child: Center(
                      child: Text(
                        'Add',
                        textAlign: TextAlign.center,
                        style: SafeGoogleFont(
                          'Sofia Pro',
                          fontSize: 16 * fFem,
                          fontWeight: FontWeight.w400,
                          height: 1.5 * fFem / fem,
                          letterSpacing: 0.3000000119 * fem,
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
