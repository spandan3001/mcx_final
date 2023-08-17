import 'package:flutter/material.dart';
import 'package:mcx_live/ui_screen.dart';
import 'package:mcx_live/utils/components/app_bar.dart';

import '../../utils/google_font.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<MapEntry> mapEntries = sets.entries.toList();
    return BackGround(
      child: Scaffold(
        appBar: appBar(
            title: "FAQ",
            onTap: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: mapEntries.length,
            itemBuilder: (context, index) {
              return QuestionCard(
                  question: mapEntries[index].key,
                  answer: mapEntries[index].value);
            },
          ),
        ),
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key, required this.question, required this.answer});
  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    double baseWidth = 360;
    double fem = w / baseWidth;
    double fFem = fem * 0.97;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "images/img.png",
          scale: 3,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question,
                style: SafeGoogleFont(
                  'Sofia Pro',
                  fontSize: fFem * 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                answer,
                style: SafeGoogleFont(
                  'Sofia Pro',
                  fontSize: fFem * 16,
                  color: Colors.black,
                  wordSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Map<String, String> sets = {
  'is there a free trial available ?':
      'One of your friends has joined by your referral code. Do more invitations to earn more.',
  'is there a refer available ?':
      'One of your friends has joined by your referral code. Do more invitations to earn more.'
};
