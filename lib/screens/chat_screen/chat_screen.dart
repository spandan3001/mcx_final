import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'input_box.dart';
import 'message_stream.dart';

class ChatScreen extends StatefulWidget {
  static const id = 'chat_screen';

  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  late String textMessage;
  final _firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("chat"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MessageStream(
              stream: _firebaseFirestore
                  .collection("messages")
                  .orderBy("timeStamp")
                  .snapshots(),
            ),
            InputMessage(
              controller: messageController,
              onPressed: () {
                textMessage = messageController.text;
                if (textMessage.trim().isNotEmpty) {
                  _firebaseFirestore.collection("messages").add({
                    'sender': "tyian3001@gmail.com",
                    "text": textMessage,
                    "timeStamp": DateTime.now()
                  });
                }
                messageController.clear();
              },
            )
          ],
        ),
      ),
    );
  }
}
