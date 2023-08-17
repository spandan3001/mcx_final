import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mcx_live/ui_screen.dart';

import '../../utils/color_constants.dart';
import '../../utils/google_font.dart';
import 'faq_question_screen.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    double baseWidth = 360;
    double fem = w / baseWidth;
    return BackGround(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'FAQ',
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
            ),
          ),
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'images/faq.png',
                  alignment: Alignment.center,
                  width: fem * 280,
                  height: fem * 255,
                ),
              ),
              CardFaq(
                title: "Get Started",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QuestionScreen()));
                },
              ),
              const CardFaq(
                title: "Features",
              ),
              const CardFaq(
                title: "Chart",
              ),
              const CardFaq(
                title: "Coming Soon",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardFaq extends StatefulWidget {
  const CardFaq({super.key, required this.title, this.onTap});
  final String title;
  final VoidCallback? onTap;

  @override
  State<CardFaq> createState() => _CardFaqState();
}

class _CardFaqState extends State<CardFaq> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    double baseWidth = 360;
    double fem = w / baseWidth;
    double fFem = fem * 0.97;
    return InkWell(
      onTap: () {
        setState(() {
          pressed = true;
        });
        if (widget.onTap != null) {
          widget.onTap!();
        }
        Timer(const Duration(milliseconds: 150), () {
          setState(() {
            pressed = false;
          });
        });
      },
      child: Container(
        height: fem * 70,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: pressed
                ? const LinearGradient(
                    begin: Alignment(0, -1),
                    end: Alignment(0, 1),
                    colors: [kGradient1, kGradient2, kGradient3],
                    stops: <double>[0, 1, 2],
                  )
                : null,
            color: pressed ? null : Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
                offset: Offset(5, 5),
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Text(
                widget.title,
                style: SafeGoogleFont(
                  'Sofia Pro',
                  fontSize: fFem * 25,
                  fontWeight: FontWeight.bold,
                  color: pressed ? Colors.white : Colors.black,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: pressed ? Colors.white : Colors.black,
              size: fFem * 25,
            )
          ],
        ),
      ),
    );
  }
}
