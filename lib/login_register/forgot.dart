import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mcx_live/screens/chat_screen/chat_screen.dart';

import '../utils/components/button.dart';
import '../utils/components/textfield.dart';

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
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        color: const Color(0xFF16171D),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),

                // welcome back
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 23),
                      child: const Text(
                        "Reset Password",
                        style: TextStyle(
                            color: Colors.white,
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

                // sign in button
                MyButton(
                  onTap: () {
                    auth
                        .sendPasswordResetEmail(
                            email: usernameController.text.toString())
                        .then((value) {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const ChatScreen()));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                            "We have sent you email to recover your password, Please check you email"),
                      ));
                    }).onError((error, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(error.toString()),
                      ));
                    });
                  },
                  text: "SEND OTP",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
