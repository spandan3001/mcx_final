import 'package:flutter/material.dart';

import '../../utils/color_constants.dart';
import '../../utils/google_font.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.8,
        height: 60,
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
            text,
            style: SafeGoogleFont(
              'Sofia Pro',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
