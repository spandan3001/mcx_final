import 'package:flutter/material.dart';

enum BuyORSell { buy, sell }

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton(
      {Key? key,
      required this.title,
      required this.onChanged,
      required this.color})
      : super(key: key);

  final String title;
  final Color color;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
