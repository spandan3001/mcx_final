import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
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
                width: 280,
                height: 255,
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
