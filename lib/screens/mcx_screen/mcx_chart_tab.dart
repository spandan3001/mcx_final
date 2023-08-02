import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import '../../utils/google_font.dart';

class MCXMainScreen extends StatefulWidget {
  const MCXMainScreen({super.key});

  @override
  State<MCXMainScreen> createState() => _MCXMainScreenState();
}

class _MCXMainScreenState extends State<MCXMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'MCX',
            textAlign: TextAlign.center,
            style: SafeGoogleFont(
              'Poppins',
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar:
            Image.asset("assets/line_chart.png", fit: BoxFit.fill),
        body: Container());
  }
}
