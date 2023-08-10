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
      border: InputBorder.none,
    );
