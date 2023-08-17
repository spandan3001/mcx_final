import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mcx_live/models/user_model.dart';
import 'package:mcx_live/utils/color_constants.dart';

import '../services/code_generator.dart';
import '../ui_screen.dart';
import '../utils/enums/gender_enum.dart';

class OtpVerifier extends StatelessWidget {
  const OtpVerifier(
      {super.key,
      required this.email,
      required this.password,
      required this.phone,
      required this.name,
      required this.refererId,
      required this.emailOTP});

  final String email;
  final String password;
  final String phone;
  final String name;
  final String? refererId;
  final EmailOTP emailOTP;

  @override
  Widget build(BuildContext context) {
    return BackGround(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          constraints: const BoxConstraints.expand(),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),

                  // Register
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "we have just sent you otp to your registered email .Please check your email and enter the otp",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                        const SizedBox(height: 20),
                        // verify button
                        FormValidationForOTP(
                          email: email,
                          password: password,
                          phone: phone,
                          name: name,
                          emailOTP: emailOTP,
                        ),
                        const SizedBox(height: 15),
                        // Already Login
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FormValidationForOTP extends StatefulWidget {
  const FormValidationForOTP({
    super.key,
    required this.email,
    required this.password,
    required this.phone,
    required this.name,
    required this.emailOTP,
    this.refererUId,
  });

  final String email;
  final String password;
  final String phone;
  final String name;
  final String? refererUId;
  final EmailOTP emailOTP;

  @override
  State<FormValidationForOTP> createState() => _FormValidationForOTPState();
}

class _FormValidationForOTPState extends State<FormValidationForOTP> {
  final _formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();

  Future<void> register() async {
    try {
      final db = FirebaseFirestore.instance;
      final auth = FirebaseAuth.instance;
      String? userId;
      await auth
          .createUserWithEmailAndPassword(
        email: widget.email,
        password: widget.password,
      )
          .then((value) async {
        Navigator.pop(context);
        userId = value.user?.uid;
      });
      final data = UserModel.toMap(
        UserModel(
            firstName: widget.name,
            secondName: widget.name,
            email: widget.email,
            number: widget.phone,
            refererUId: widget.refererUId,
            wallet: "100.0",
            gender: Gender.non.name,
            referCode: CodeGenerator.generateCode(),
            id: '',
            imageUrl: "",
            depositForRefer: false,
            upiId: widget.phone),
      );
      await db.collection("users").doc(userId).set(data);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // displaying error
      errorMessage(e.code);
    }
  }

  void errorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.red[800],
          title: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  void verify() async {
    //print(widget.email);
    widget.emailOTP.setConfig(
        appEmail: "spandanchintu222@gmail.com",
        appName: "email_otp",
        userEmail: widget.email,
        otpLength: 6,
        otpType: OTPType.digitsOnly);
    //print(OtpController.text);
    //print(myAuth.verifyOTP(otp: OtpController.text));
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    if (await widget.emailOTP.verifyOTP(otp: otpController.text) == true) {
      Navigator.pop(context);
      await register();
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Invalid OTP")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: otpController,
            style: const TextStyle(
              color: Colors.black,
            ),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              labelText: 'OTP',
              labelStyle: const TextStyle(
                color: Colors.black,
              ),
              hintText: "please enter the OTP",
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kGradient1,
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                verify();
              }
            },
            child: const Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
