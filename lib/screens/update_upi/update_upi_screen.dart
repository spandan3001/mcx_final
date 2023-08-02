import 'package:flutter/material.dart';
import 'package:mcx_live/utils/color_constants.dart';
import 'package:mcx_live/utils/text_style.dart';

import '../../utils/form_validator.dart';

class UpdateUpiScreen extends StatefulWidget {
  const UpdateUpiScreen({super.key});

  @override
  State<UpdateUpiScreen> createState() => _UpdateUpiScreenState();
}

class _UpdateUpiScreenState extends State<UpdateUpiScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double fFem = fem * 0.97;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'UPDATE UPI',
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //image bim
              SizedBox(
                width: 172 * fem,
                height: 43 * fem,
                child: Image.asset(
                  'assets/bmi.png',
                  width: 172 * fem,
                  height: 43 * fem,
                ),
              ),

              const SizedBox(height: 50),

              //input box
              FormValidationTextField(
                formKey: _formKey,
                labelText: "UPI ID",
                hintText: "please enter the upi id",
                fem: fem,
                fFem: fFem,
              ),

              const SizedBox(height: 30),

              // upload scanner
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: kBorderColor),
                  color: kWhite,
                  borderRadius: BorderRadius.circular(14 * fem),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: kShadowColor,
                  //     offset: Offset(0 * fem, 2 * fem),
                  //     blurRadius: 5 * fem,
                  //     spreadRadius: -1 * fem,
                  //   ),
                  // ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Upload Scanner',
                      style: SafeGoogleFont(
                        'Poppins',
                        fontSize: 17.7665576935 * fFem,
                        fontWeight: FontWeight.w400,
                        height: 1.5000000537 * fFem / fem,
                        color: const Color(0xff000000),
                      ),
                    ),
                    SizedBox(
                      width: 40 * fem,
                      height: 40 * fem,
                      child: IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/upload.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }
                },
                borderRadius: BorderRadius.circular(100 * fem),
                child: Container(
                  padding: EdgeInsets.all(fem * 10),
                  width: fem * 160,
                  height: fem * 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100 * fem),
                    gradient: const LinearGradient(
                      begin: Alignment(1, 1),
                      end: Alignment(-1, -1),
                      colors: <Color>[
                        Color(0xff12c1fc),
                        Color(0xff4171ff),
                        Color(0xff5459ff)
                      ],
                      stops: <double>[0, 0.589, 1],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Update',
                      textAlign: TextAlign.center,
                      style: SafeGoogleFont(
                        'Sofia Pro',
                        fontSize: 19 * fFem,
                        fontWeight: FontWeight.w400,
                        height: 1.2575 * fFem / fem,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
