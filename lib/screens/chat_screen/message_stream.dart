import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mcx_live/screens/chat_screen/model/message_model.dart';
import 'package:provider/provider.dart';
import '../../provider_classes/user_details_provider.dart';
import 'message_bubble.dart';

class MessageStream extends StatelessWidget {
  final Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  const MessageStream({Key? key, required this.stream}) : super(key: key);

  List<MessageBubble> getData(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      {required BuildContext context}) {
    List<MessageBubble> messagesList = [];
    final messages =
        snapshot.data!.docs.map((e) => MessageModel.fromSnapshot(e));
    for (MessageModel messageModel in messages) {
      final textMessage = messageModel.text;
      final textSender = messageModel.email;

      final userMail =
          Provider.of<UserProvider>(context, listen: false).getEmail();

      messagesList.add(
        MessageBubble(
          text: textMessage.trim(),
          sender: textSender,
          isMe: userMail == textSender ? true : false,
        ),
      );
    }
    return messagesList;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blueGrey,
            ),
          );
        }
        List<MessageBubble> messagesList = getData(snapshot, context: context);
        //List<MessageBubble> messagesList = [];
        return Expanded(
          child: ListView.builder(
            itemCount: messagesList.length,
            reverse: true,
            itemBuilder: (context, index) => messagesList[index],
          ),
        );
      },
    );
  }
}
