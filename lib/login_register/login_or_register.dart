import 'package:flutter/material.dart';
import 'login.dart';

import 'register_screen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => LoginOrRegisterState();
}

class LoginOrRegisterState extends State<LoginOrRegister> {
  //  initially show login page
  bool showLogin = true;

  // toogle between login and register
  void tooglePages() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return Login(
        onTap: tooglePages,
      );
    } else {
      return Register(
        onTap: tooglePages,
      );
    }
  }
}
