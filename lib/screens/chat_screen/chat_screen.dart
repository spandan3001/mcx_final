import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mcx_live/services/firestore_services.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../provider_classes/user_details_provider.dart';
import '../../utils/google_font.dart';
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
  //final _firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String email = Provider.of<UserProvider>(context, listen: false).getEmail();
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          'CHAT',
          textAlign: TextAlign.center,
          style: SafeGoogleFont(
            'Poppins',
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MessageStream(
              stream: CloudService.messageCollection
                  .orderBy("timeStamp", descending: true)
                  .snapshots(),
            ),
            InputMessage(
              controller: messageController,
              onPressed: () {
                textMessage = messageController.text;
                if (textMessage.trim().isNotEmpty) {
                  CloudService.messageCollection.add({
                    'sender': email,
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
