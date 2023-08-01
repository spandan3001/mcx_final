import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'constants.dart';

class InputMessage extends StatefulWidget {
  const InputMessage({Key? key, this.controller, required this.onPressed})
      : super(key: key);

  final TextEditingController? controller;
  final VoidCallback onPressed;

  @override
  State<InputMessage> createState() => _InputMessageState();
}

class _InputMessageState extends State<InputMessage> {
  final User? loggedInUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextField(
        controller: widget.controller,
        style: const TextStyle(fontSize: 18, color: Colors.white),
        maxLines: null,
        decoration: kTextInputDecoration(
          suffixIcon: IconButton(
            onPressed: widget.onPressed,
            icon: const Icon(Icons.send),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
