import 'package:flutter/material.dart';
import 'package:mcx_live/utils/color_constants.dart';

import 'text_style.dart';

class FormValidationTextField extends StatefulWidget {
  const FormValidationTextField(
      {super.key,
      required this.formKey,
      this.labelText,
      this.hintText,
      required this.fem,
      required this.fFem});

  final GlobalKey<FormState> formKey;
  final String? labelText;
  final String? hintText;
  final double fem;
  final double fFem;

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
            fontSize: 17.7665576935 * widget.fFem,
            fontWeight: FontWeight.w400,
            height: 1.5000000537 * widget.fFem / widget.fem,
            color: const Color(0xff000000),
          ),
          hintText: widget.hintText,
          hintStyle: SafeGoogleFont(
            'Poppins',
            fontSize: 17.7665576935 * widget.fFem,
            fontWeight: FontWeight.w400,
            height: 1.5000000537 * widget.fFem / widget.fem,
            color: const Color(0xff000000),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14 * widget.fem),
            borderSide: const BorderSide(
              color: kBorderColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14 * widget.fem),
            borderSide: const BorderSide(
              color: kBorderColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14 * widget.fem),
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
