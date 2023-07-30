import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
              color: Color(0xFF21242D),
            )),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFF5C249),
                ),
                borderRadius: BorderRadius.circular(10)),
            fillColor: const Color(0xFF21242D),
            filled: true,
            hintText: hintText,
            hintStyle: const TextStyle(color: Color(0xFF494D58), fontSize: 18)),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
