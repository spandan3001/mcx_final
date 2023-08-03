import 'package:flutter/material.dart';
import 'package:mcx_live/utils/text_style.dart';

class AddRemoveScreen extends StatefulWidget {
  const AddRemoveScreen({super.key});

  @override
  State<AddRemoveScreen> createState() => _AddRemoveScreenState();
}

class _AddRemoveScreenState extends State<AddRemoveScreen> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double fFem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ADD & REMOVE',
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
      body: SizedBox(
        width: double.infinity,
        child: Container(
          padding: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0.42 * fem),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding:
                    EdgeInsets.fromLTRB(24 * fem, 24 * fem, 23 * fem, 39 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // autogroupk4jb2xH (VSFopM5zsYezXwT7Xmk4jB)
                      margin: EdgeInsets.fromLTRB(
                          14 * fem, 0 * fem, 89.5 * fem, 62 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            // addremovexb3 (143:91)
                            child: Text(
                              'Add & Remove  ',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont(
                                'Poppins',
                                fontSize: 16.9899997711 * fFem,
                                fontWeight: FontWeight.w500,
                                height: 1.5685602032 * fFem / fem,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // group181825Qm (143:93)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 28 * fem),
                      padding: EdgeInsets.fromLTRB(
                          13 * fem, 22 * fem, 13 * fem, 10 * fem),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(15 * fem),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x59000000),
                            offset: Offset(0 * fem, 3 * fem),
                            blurRadius: 6.5 * fem,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // autogroup323j8dw (VSFpDW65m7gmUiEpB3323j)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 93 * fem, 18 * fem),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  // group177874Xb (143:108)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 49.05 * fem, 1 * fem),
                                  width: 32.95 * fem,
                                  height: 22 * fem,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(100 * fem),
                                    gradient: const LinearGradient(
                                      begin: Alignment(0, -1),
                                      end: Alignment(0, 1),
                                      colors: <Color>[
                                        Color(0xff12c1fc),
                                        Color(0xff0994fd)
                                      ],
                                      stops: <double>[0, 1],
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '1',
                                      style: SafeGoogleFont(
                                        'Sofia Pro',
                                        fontSize: 11.6949138641 * fFem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2575 * fFem / fem,
                                        color: const Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  // fGV (143:98)
                                  '265485465465446',
                                  style: SafeGoogleFont(
                                    'Sofia Pro',
                                    fontSize: 15 * fFem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2575 * fFem / fem,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // autogrouprudk15T (VSFpPuxQEUb6eKQ6a3rudK)
                            margin: EdgeInsets.fromLTRB(
                                20 * fem, 0 * fem, 113 * fem, 16 * fem),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // nameLNd (143:101)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 39 * fem, 0 * fem),
                                  child: Text(
                                    'Name',
                                    style: SafeGoogleFont(
                                      'Sofia Pro',
                                      fontSize: 15 * fFem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2575 * fFem / fem,
                                      color: const Color(0xff564c4c),
                                    ),
                                  ),
                                ),
                                Text(
                                  // rockygoyal43j (143:97)
                                  'Rocky Goyal',
                                  style: SafeGoogleFont(
                                    'Sofia Pro',
                                    fontSize: 15 * fFem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2575 * fFem / fem,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // autogroupjfshPrh (VSFpVQoExmC9oZndVxjFSH)
                            margin: EdgeInsets.fromLTRB(
                                20 * fem, 0 * fem, 35 * fem, 16 * fem),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // email7Xo (143:95)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 41 * fem, 0 * fem),
                                  child: Text(
                                    'Email',
                                    style: SafeGoogleFont(
                                      'Sofia Pro',
                                      fontSize: 15 * fFem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2575 * fFem / fem,
                                      color: const Color(0xff564c4c),
                                    ),
                                  ),
                                ),
                                Text(
                                  // rockygoyalgmailcom2uf (143:99)
                                  'Rocky Goyal@gmail.com',
                                  style: SafeGoogleFont(
                                    'Sofia Pro',
                                    fontSize: 15 * fFem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2575 * fFem / fem,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // autogroupfcmxyK7 (VSFpaQeuzJ77QLWCtcFCMX)
                            margin: EdgeInsets.fromLTRB(
                                20 * fem, 0 * fem, 150 * fem, 21 * fem),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // amounti1o (143:96)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 26 * fem, 0 * fem),
                                  child: Text(
                                    'Amount',
                                    style: SafeGoogleFont(
                                      'Sofia Pro',
                                      fontSize: 15 * fFem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2575 * fFem / fem,
                                      color: const Color(0xff564c4c),
                                    ),
                                  ),
                                ),
                                Text(
                                  // pKj (143:100)
                                  '5000/-',
                                  style: SafeGoogleFont(
                                    'Sofia Pro',
                                    fontSize: 15 * fFem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2575 * fFem / fem,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // autogroupck89mVs (VSFpfKgPjNQPQhGxMiCk89)
                            margin: EdgeInsets.fromLTRB(
                                22 * fem, 0 * fem, 24 * fem, 0 * fem),
                            width: double.infinity,
                            height: 43 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // group17821VAy (143:102)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 49 * fem, 0 * fem),
                                  width: 96 * fem,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(100 * fem),
                                    gradient: const LinearGradient(
                                      begin: Alignment(1, 1),
                                      end: Alignment(-1, -1),
                                      colors: <Color>[
                                        Color(0xff12c1fc),
                                        Color(0xff0994fd)
                                      ],
                                      stops: <double>[0, 1],
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Accept',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont(
                                        'Sofia Pro',
                                        fontSize: 13 * fFem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2575 * fFem / fem,
                                        color: const Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  // group178187TF (143:105)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 0.13 * fem),
                                  width: 96 * fem,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(100 * fem),
                                    gradient: const LinearGradient(
                                      begin: Alignment(1, 1),
                                      end: Alignment(-1, -1),
                                      colors: <Color>[
                                        Color(0xff12c1fc),
                                        Color(0xff0994fd)
                                      ],
                                      stops: <double>[0, 1],
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Reject',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont(
                                        'Sofia Pro',
                                        fontSize: 13 * fFem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2575 * fFem / fem,
                                        color: const Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // group181838NM (143:115)
                      padding: EdgeInsets.fromLTRB(
                          13 * fem, 25 * fem, 13 * fem, 7 * fem),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(15 * fem),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x59000000),
                            offset: Offset(0 * fem, 3 * fem),
                            blurRadius: 6.5 * fem,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // autogroupgqru1S9 (VSFqCZHM9T7NuWkoYkgQru)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 93 * fem, 22 * fem),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  // group17787wah (143:128)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 49.05 * fem, 1 * fem),
                                  width: 32.95 * fem,
                                  height: 22 * fem,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(100 * fem),
                                    gradient: const LinearGradient(
                                      begin: Alignment(0, -1),
                                      end: Alignment(0, 1),
                                      colors: <Color>[
                                        Color(0xff12c1fc),
                                        Color(0xff0994fd)
                                      ],
                                      stops: <double>[0, 1],
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '2',
                                      style: SafeGoogleFont(
                                        'Sofia Pro',
                                        fontSize: 11.6949138641 * fFem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2575 * fFem / fem,
                                        color: const Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  // ACZ (143:119)
                                  '265485465465446',
                                  style: SafeGoogleFont(
                                    'Sofia Pro',
                                    fontSize: 15 * fFem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2575 * fFem / fem,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // autogroupr6uqufw (VSFqPYy2c2KVE1XsQaR6Uq)
                            margin: EdgeInsets.fromLTRB(
                                20 * fem, 0 * fem, 113 * fem, 16 * fem),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // namedbw (143:121)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 39 * fem, 0 * fem),
                                  child: Text(
                                    'Name',
                                    style: SafeGoogleFont(
                                      'Sofia Pro',
                                      fontSize: 15 * fFem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2575 * fFem / fem,
                                      color: const Color(0xff564c4c),
                                    ),
                                  ),
                                ),
                                Text(
                                  // rockygoyaljus (143:118)
                                  'Rocky Goyal',
                                  style: SafeGoogleFont(
                                    'Sofia Pro',
                                    fontSize: 15 * fFem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2575 * fFem / fem,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // autogroupvsyh5iq (VSFqUdetv1r8RCCGimVSYh)
                            margin: EdgeInsets.fromLTRB(
                                20 * fem, 0 * fem, 35 * fem, 16 * fem),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // emailDq3 (143:117)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 41 * fem, 0 * fem),
                                  child: Text(
                                    'Email',
                                    style: SafeGoogleFont(
                                      'Sofia Pro',
                                      fontSize: 15 * fFem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2575 * fFem / fem,
                                      color: const Color(0xff564c4c),
                                    ),
                                  ),
                                ),
                                Text(
                                  // rockygoyalgmailcomYMX (143:120)
                                  'Rocky Goyal@gmail.com',
                                  style: SafeGoogleFont(
                                    'Sofia Pro',
                                    fontSize: 15 * fFem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2575 * fFem / fem,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // autogroupopd35sF (VSFqa3fYMqqVz2dyj8oPD3)
                            margin: EdgeInsets.fromLTRB(
                                20 * fem, 0 * fem, 150 * fem, 17 * fem),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // amountd85 (143:135)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 26 * fem, 0 * fem),
                                  child: Text(
                                    'Amount',
                                    style: SafeGoogleFont(
                                      'Sofia Pro',
                                      fontSize: 15 * fFem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2575 * fFem / fem,
                                      color: const Color(0xff564c4c),
                                    ),
                                  ),
                                ),
                                Text(
                                  // kyP (143:136)
                                  '5000/-',
                                  style: SafeGoogleFont(
                                    'Sofia Pro',
                                    fontSize: 15 * fFem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2575 * fFem / fem,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // autogroupkvyfuLV (VSFqexh26v8mzPQjCEkvyf)
                            margin: EdgeInsets.fromLTRB(
                                22 * fem, 0 * fem, 24 * fem, 0 * fem),
                            width: double.infinity,
                            height: 43 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // group178212vu (143:122)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 49 * fem, 0 * fem),
                                  width: 96 * fem,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(100 * fem),
                                    gradient: const LinearGradient(
                                      begin: Alignment(1, 1),
                                      end: Alignment(-1, -1),
                                      colors: <Color>[
                                        Color(0xff12c1fc),
                                        Color(0xff0994fd)
                                      ],
                                      stops: <double>[0, 1],
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Accept',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont(
                                        'Sofia Pro',
                                        fontSize: 13 * fFem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2575 * fFem / fem,
                                        color: const Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  // group17818G4Z (143:125)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 0.13 * fem),
                                  width: 96 * fem,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(100 * fem),
                                    gradient: const LinearGradient(
                                      begin: Alignment(1, 1),
                                      end: Alignment(-1, -1),
                                      colors: <Color>[
                                        Color(0xff12c1fc),
                                        Color(0xff0994fd)
                                      ],
                                      stops: <double>[0, 1],
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Reject',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont(
                                        'Sofia Pro',
                                        fontSize: 13 * fFem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2575 * fFem / fem,
                                        color: const Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
