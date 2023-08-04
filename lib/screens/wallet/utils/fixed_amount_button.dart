import 'package:flutter/material.dart';

import '../../../utils/color_constants.dart';
import '../../../utils/google_font.dart';
import 'enums.dart';

class AmountButton extends StatelessWidget {
  const AmountButton(
      {super.key,
      required this.selected,
      required this.onTap,
      required this.value});
  final Amount selected;
  final Amount value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: w * 0.25,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selected == value ? kGradient1 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            '₹${value.name.substring(1)}',
            style: SafeGoogleFont(
              'Sofia Pro',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: selected == value ? kWhite : kAmountColor,
            ),
          ),
        ),
      ),
    );
  }
}
