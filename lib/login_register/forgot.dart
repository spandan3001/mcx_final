import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mcx_live/ui_screen.dart';
import 'package:mcx_live/utils/components/app_bar.dart';

import '../utils/color_constants.dart';
import '../utils/components/button.dart';
import '../utils/components/textfield.dart';
import '../utils/google_font.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  // controller
  final usernameController = TextEditingController();
  final auth = FirebaseAuth.instance;

  // signIn method

  // Error Message

  // wrong Password Message

  @override
  Widget build(BuildContext context) {
    return BackGround(
      child: Scaffold(
        appBar: appBar(
            title: "RESET PASSWORD",
            onTap: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.transparent,
        body: Container(
          constraints: const BoxConstraints.expand(),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 23),
                        child: const Text(
                          "Reset Password",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // username

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 23),
                        child: const Text(
                          "Please enter your email address",
                          style:
                              TextStyle(color: Color(0xFF21242D), fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),

                  const SizedBox(height: 30),

                  MyTextField(
                    controller: usernameController,
                    hintText: 'Your email',
                    obscureText: false,
                  ),

                  const SizedBox(height: 35),

                  InkWell(
                    onTap: () {
                      auth
                          .sendPasswordResetEmail(
                              email: usernameController.text.toString())
                          .then(
                        (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(
                                  "We have sent you email to recover your password, Please check you email"),
                            ),
                          );
                        },
                      ).onError((error, stackTrace) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(error.toString()),
                        ));
                      });
                    },
                    child: Container(
                      height: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          begin: Alignment(0, -1),
                          end: Alignment(0, 1),
                          colors: [kGradient1, kGradient2, kGradient3],
                          stops: <double>[0, 1, 2],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "SignUp",
                          style: SafeGoogleFont(
                            'Sofia Pro',
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
