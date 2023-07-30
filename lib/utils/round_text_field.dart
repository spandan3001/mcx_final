import 'package:flutter/material.dart';
import 'color_constants.dart';
import 'google_font.dart';

InputDecoration getInputDecoration({String? labelText, String? hintText}) {
  return InputDecoration(
    fillColor: kWhite,
    labelText: labelText,
    labelStyle: SafeGoogleFont(
      'Poppins',
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: const Color(0xff000000),
    ),
    hintText: hintText,
    hintStyle: SafeGoogleFont(
      'Poppins',
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: const Color(0xff000000),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        color: kBorderColor,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        color: kBorderColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        color: kBorderColor,
      ),
    ),
  );
}
