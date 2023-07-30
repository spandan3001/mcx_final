import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/components/button.dart';
import '../utils/components/textfield.dart';
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
    return Scaffold(
      body: Container(
        color: const Color(0xFF16171D),
        constraints: const BoxConstraints.expand(),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),

                // welcome back
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 23),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 80),

                // username

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 23),
                      child: const Text(
                        "E-mail",
                        style:
                            TextStyle(color: Color(0xFFA7AEBF), fontSize: 18),
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
                      child: const Text(
                        "Password",
                        style:
                            TextStyle(color: Color(0xFFA7AEBF), fontSize: 18),
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
                                  color: Color(0xFFF5C249),
                                )
                              : const Icon(Icons.visibility_off,
                                  color: Color(0xFFF5C249), size: 25),
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xFF21242D),
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFFF5C249),
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        fillColor: const Color(0xFF21242D),
                        filled: true,
                        hintText: "Password",
                        hintStyle: const TextStyle(
                            color: Color(0xFFF494D58), fontSize: 18)),
                    style: const TextStyle(color: Colors.white),
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
                                color: Color(0xFFF5C249),
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // sign in button
                MyButton(
                  onTap: signIn,
                  text: "LOGIN",
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
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Color(0xFFF5C249),
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 20),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
