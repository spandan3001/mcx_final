import 'package:flutter/material.dart';

import '../../utils/color_constants.dart';
import '../../utils/google_font.dart';

class CardButton extends StatelessWidget {
  const CardButton({super.key, required this.name, required this.onPressed});
  final String name;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.3,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          gradient: const LinearGradient(
            begin: Alignment(-1, 1),
            end: Alignment(2, 1),
            colors: <Color>[kGradient1, kGradient2],
            stops: <double>[0.3, 1],
          ),
        ),
        child: Center(
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: SafeGoogleFont(
              'Sofia Pro',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          ),
        ),
      ),
    );
  }
}
