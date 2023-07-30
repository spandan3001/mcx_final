import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/components/button.dart';
import '../utils/components/textfield.dart';
import 'otp_verification.dart';

class Register extends StatefulWidget {
  final Function()? onTap;
  static String verify = "";
  const Register({super.key, required this.onTap});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // controller
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final nameController = TextEditingController();

  final PhoneController = TextEditingController();

  bool pass = true;
  EmailOTP myAuth = EmailOTP();

  void visible() {
    setState(() {
      pass = !pass;
    });
  }

  // sign Up method
  void signUp() async {
    // Lodding Circle
    final name = nameController.text;
    final email = usernameController.text;
    final phone = PhoneController.text;
    //var verificationId = '';

    //storing data

    // creating the user process

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      final _db = FirebaseFirestore.instance;
      var res = await _db
          .collection("users")
          .where("number", isEqualTo: phone.toString())
          .get();
      if (res.docs.length > 0) {
        Navigator.pop(context);
        ErrorMessage("This number is already registered");
      } else {
        myAuth.setConfig(
            appEmail: "spandanchintu222@gmail.com",
            appName: "email_otp",
            userEmail: email,
            otpLength: 6,
            otpType: OTPType.digitsOnly);
        if (await myAuth.sendOTP() == true) {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmailVerifier(
                emailOTP: myAuth,
                email: email,
                password: passwordController.text,
                phone: phone.toString(),
                name: name,
              ),
            ),
          );
          // Navigator.pop(context);
          // ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(content: Text("OTP sent successfully")));
        } else {
          print('dones');
        }
      }
    } on Exception catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // displaying error
      ErrorMessage(e.toString());
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
        constraints: const BoxConstraints.expand(),
        color: const Color(0xFF16171D),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),

                // Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 23),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 70),

                // username

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 23),
                      child: const Text(
                        "Full Name",
                        style:
                            TextStyle(color: Color(0xFFA7AEBF), fontSize: 18),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                MyTextField(
                  controller: nameController,
                  hintText: 'Name',
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
                  hintText: 'Your Email',
                  obscureText: false,
                ),

                const SizedBox(height: 15),

                // conform password

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
                            borderSide: BorderSide(color: Color(0xFF21242D))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFFF5C249)),
                            borderRadius: BorderRadius.circular(10)),
                        fillColor: const Color(0xFF21242D),
                        filled: true,
                        hintText: "Password",
                        hintStyle: const TextStyle(
                            color: Color(0xFFF494D58), fontSize: 18)),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 23),
                      child: const Text(
                        "Contact details",
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
                    controller: PhoneController,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF21242D))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFFF5C249)),
                            borderRadius: BorderRadius.circular(10)),
                        fillColor: const Color(0xFF21242D),
                        filled: true,
                        hintText: "Phone number",
                        hintStyle: const TextStyle(
                            color: Color(0xFFF494D58), fontSize: 18)),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),

                // sign up button
                MyButton(
                  onTap: signUp,
                  text: "Sign Up",
                ),

                const SizedBox(height: 15),

                // Already Login

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Color(0xFFF5C249),
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
