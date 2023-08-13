import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

InputDecoration kMessageTextFieldDecoration =
    const InputDecoration(hintText: 'Message', border: InputBorder.none);

InputDecoration kTextInputDecoration(
    {String lableText = "", String hintText = "Message", Widget? suffixIcon}) {
  return InputDecoration(
    labelText: lableText,
    hintText: hintText,
    hintStyle: const TextStyle(fontSize: 18, color: Colors.white),
    labelStyle: const TextStyle(fontSize: 18, color: Colors.white),
    fillColor: Colors.white,
    filled: true,
    suffixIcon: suffixIcon,
    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
    focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius(),
        borderSide: const BorderSide(color: Colors.black)),
    enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius(),
        borderSide: const BorderSide(color: Colors.black)),
    errorBorder: OutlineInputBorder(
        borderRadius: borderRadius(),
        borderSide: const BorderSide(color: Colors.red, width: 2.0)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: borderRadius(),
        borderSide: const BorderSide(color: Colors.red, width: 2.0)),
  );
}

BorderRadius borderRadius() {
  return const BorderRadius.only(
    topRight: Radius.circular(20.0),
    topLeft: Radius.circular(20.0),
    bottomLeft: Radius.circular(20.0),
    bottomRight: Radius.circular(20.0),
  );
}
