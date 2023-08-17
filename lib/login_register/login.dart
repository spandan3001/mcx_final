import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ui_screen.dart';
import '../utils/color_constants.dart';
import '../utils/components/button.dart';
import '../utils/components/textfield.dart';
import '../utils/google_font.dart';
import 'forgot.dart';

class Login extends StatefulWidget {
  final Function()? onTap;
  const Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // controller
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  bool pass = true;

  void visible() {
    setState(() {
      pass = !pass;
    });
  }

  // signIn method
  void signIn() async {
    // Lodding Circle

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Sign in process
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController.text, password: passwordController.text);

      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);

      // Wrong Username
      if (e.code == 'user-not-found') {
        ErrorMessage("User Not Registered");
      }

      // Wrong Password
      else if (e.code == 'wrong-password') {
        ErrorMessage("Incorrect Password");
      }
    }
  }

  // Error Message
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

  // wrong Password Message

  @override
  Widget build(BuildContext context) {
    return BackGround(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "LOGIN",
            style: SafeGoogleFont(
              'Sofia Pro',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          centerTitle: true,
        ),
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
                        child: Text(
                          "E-mail",
                          style: SafeGoogleFont(
                            'Poppins',
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  MyTextField(
                    controller: usernameController,
                    hintText: 'Your email',
                    obscureText: false,
                  ),

                  const SizedBox(height: 15),
                  // password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 23),
                        child: Text(
                          "Password",
                          style: SafeGoogleFont(
                            'Poppins',
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: passwordController,
                      obscureText: pass,
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: visible,
                            child: pass == true
                                ? const Icon(
                                    Icons.visibility,
                                    size: 25,
                                    color: Colors.black,
                                  )
                                : const Icon(Icons.visibility_off,
                                    color: Colors.black, size: 25),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Password",
                          hintStyle: const TextStyle(
                              color: Color(0xFFF494D58), fontSize: 18)),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),

                  const SizedBox(height: 35),

                  // forgot password
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () => {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => const Forgot()))
                                },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  color: kGradient1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  // sign in button
                  InkWell(
                    onTap: signIn,
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
                          "Login",
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

                  const SizedBox(height: 20),

                  // not a member,Register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                            color: Color(0xFFA7AEBF),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Sign Up',
                          style: SafeGoogleFont(
                            'Sofia Pro',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kGradient1,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
