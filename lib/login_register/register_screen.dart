import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/user_model.dart';
import '../utils/components/button.dart';
import '../utils/components/show_dialog.dart';
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

  final phoneController = TextEditingController();
  final referController = TextEditingController();

  bool pass = true;
  bool referVerifyPresent = true;
  String? refererUid;
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
    final phone = phoneController.text;
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
      NavigatorState state = Navigator.of(context);
      final db = FirebaseFirestore.instance;
      var res = await db
          .collection("users")
          .where("number", isEqualTo: phone.toString())
          .get();
      if (res.docs.isNotEmpty) {
        state.pop();
        errorMessage("This number is already registered");
      } else {
        myAuth.setConfig(
            appEmail: "spandanchintu222@gmail.com",
            appName: "email_otp",
            userEmail: email,
            otpLength: 6,
            otpType: OTPType.digitsOnly);

        if (await myAuth.sendOTP() == true) {
          state.pop();
          state.push(
            MaterialPageRoute(
              builder: (context) => OtpVerifier(
                emailOTP: myAuth,
                email: email,
                password: passwordController.text,
                phone: phone.toString(),
                name: name,
                refererId: refererUid,
              ),
            ),
          );
        } else {
          showAlertDialog(context,
              text: 'There was a error while sending otp', title: 'Error');
        }
      }
    } on Exception catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // displaying error
      errorMessage(e.toString());
    }
  }

  // Error Message
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

  // wrong Password Message

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF16171D),
      body: Center(
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
                      style: TextStyle(color: Color(0xFFA7AEBF), fontSize: 18),
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
                      style: TextStyle(color: Color(0xFFA7AEBF), fontSize: 18),
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
                      style: TextStyle(color: Color(0xFFA7AEBF), fontSize: 18),
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
                          color: Color(0xFF494D58), fontSize: 18)),
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
                      style: TextStyle(color: Color(0xFFA7AEBF), fontSize: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: phoneController,
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
                          color: Color(0xFF494D58), fontSize: 18)),
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
                      "Referral code",
                      style: TextStyle(color: Color(0xFFA7AEBF), fontSize: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: referController,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    suffix: referVerifyPresent
                        ? InkWell(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );
                              final db = FirebaseFirestore.instance;
                              NavigatorState state = Navigator.of(context);
                              var res = await db
                                  .collection("users")
                                  .where("referCode",
                                      isEqualTo: referController.text)
                                  .get();

                              if (res.docs.isNotEmpty) {
                                UserModel userModel =
                                    UserModel.fromSnapshot(res.docs.single);

                                refererUid = userModel.id;
                                //pop and show confirm dialog
                                state.pop();
                                showAlertDialog(context,
                                    text:
                                        "you have been referred by ${userModel.firstName}?",
                                    title: "confirm");
                              } else {
                                state.pop();
                                errorMessage(
                                    "could not find the users,try again");
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5C249),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                "Verify",
                                style: TextStyle(
                                    color: Color(0xFF494D58), fontSize: 15),
                              ),
                            ),
                          )
                        : null,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF21242D),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFF5C249),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    fillColor: const Color(0xFF21242D),
                    filled: true,
                    hintText: "8-digit code",
                    hintStyle:
                        const TextStyle(color: Color(0xFF494D58), fontSize: 18),
                  ),
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
    );
  }
}
