import 'package:flutter/material.dart';
import 'package:mcx_live/utils/color_constants.dart';

import 'text_style.dart';

class FormValidationTextField extends StatefulWidget {
  const FormValidationTextField({
    super.key,
    required this.formKey,
    this.labelText,
    this.hintText,
    required this.controller,
  });

  final GlobalKey<FormState> formKey;
  final String? labelText;
  final String? hintText;
  final TextEditingController controller;

  @override
  State<FormValidationTextField> createState() =>
      _FormValidationTextFieldState();
}

class _FormValidationTextFieldState extends State<FormValidationTextField> {
  String _textValue = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: TextFormField(
        controller: widget.controller,
        style: SafeGoogleFont(
          'Poppins',
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: const Color(0xff000000),
        ),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          fillColor: kWhite,
          labelText: widget.labelText,
          labelStyle: SafeGoogleFont(
            'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: const Color(0xff000000),
          ),
          hintText: widget.hintText,
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
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        onSaved: (value) {
          _textValue = value!;
        },
      ),
    );
  }
}
