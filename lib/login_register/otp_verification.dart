import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sidepanel_flutter/models/user_model.dart';
import 'package:sidepanel_flutter/utils/color_constants.dart';

class EmailVerifier extends StatelessWidget {
  const EmailVerifier(
      {super.key,
      required this.email,
      required this.password,
      required this.phone,
      required this.name,
      required this.emailOTP});

  final String email;
  final String password;
  final String phone;
  final String name;
  final EmailOTP emailOTP;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      constraints: const BoxConstraints.expand(),
      color: const Color(0xFF16171D),
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
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: kWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    const SizedBox(height: 20),
                    // verify button
                    FormValidationTextField(
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
    ));
  }
}

class FormValidationTextField extends StatefulWidget {
  const FormValidationTextField({
    super.key,
    required this.email,
    required this.password,
    required this.phone,
    required this.name,
    required this.emailOTP,
  });

  final String email;
  final String password;
  final String phone;
  final String name;
  final EmailOTP emailOTP;

  @override
  State<FormValidationTextField> createState() =>
      _FormValidationTextFieldState();
}

class _FormValidationTextFieldState extends State<FormValidationTextField> {
  final _formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();

  Future<void> register() async {
    try {
      final _db = FirebaseFirestore.instance;
      final _auth = FirebaseAuth.instance;
      String? userId;
      await _auth
          .createUserWithEmailAndPassword(
        email: widget.email,
        password: widget.password,
      )
          .then((value) async {
        Navigator.pop(context);
        userId = value.user?.uid;
      });

      final obj = {
        "name": widget.name,
        "email": widget.email,
        "number": widget.phone,
        "wallet": "100.0"
      };
      await _db.collection("users").doc(userId).set(obj);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // displaying error
      ErrorMessage(e.code);
    }
  }

  void ErrorMessage(String message) {
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
    if (await widget.emailOTP.verifyOTP(otp: otpController.text) == true) {
      await register();
    } else {
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
              color: Colors.white,
            ),
            cursorColor: const Color.fromRGBO(245, 194, 73, 1),
            decoration: InputDecoration(
              labelText: 'OTP',
              labelStyle: const TextStyle(
                color: Color.fromRGBO(245, 194, 73, 1),
              ),
              hintText: "please enter the OTP",
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(245, 194, 73, 1),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(245, 194, 73, 1),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(245, 194, 73, 1),
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
              backgroundColor: const Color.fromRGBO(245, 194, 73, 1),
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                verify();
              }
            },
            child: const Text(
              'Submit',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
