import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'constants.dart';

class InputMessage extends StatefulWidget {
  const InputMessage(
      {Key? key,
      this.controller,
      required this.onPressed,
      this.onPressedForImage})
      : super(key: key);

  final TextEditingController? controller;
  final VoidCallback onPressed;
  final VoidCallback? onPressedForImage;

  @override
  State<InputMessage> createState() => _InputMessageState();
}

class _InputMessageState extends State<InputMessage> {
  final User? loggedInUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 45,
              width: double.infinity,
              child: TextField(
                controller: widget.controller,
                style: const TextStyle(fontSize: 18, color: Colors.black),
                maxLines: null,
                decoration: kTextInputDecoration(
                  suffixIcon: IconButton(
                    onPressed: widget.onPressedForImage,
                    icon: Transform.rotate(
                        angle: 10, child: const Icon(Icons.attach_file_sharp)),
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: widget.onPressed,
            icon: const Icon(Icons.send),
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
