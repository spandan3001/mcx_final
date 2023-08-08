import 'package:flutter/material.dart';
import 'package:mcx_live/utils/color_constants.dart';

InputDecoration inputDecorationForTextField({String? label, String? hint}) =>
    InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: kBorderColor,
      ),
      hintText: hint,
      hintStyle: const TextStyle(
        color: Colors.grey,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: kBorderColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: kBorderColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: kBorderColor,
        ),
      ),
    );
