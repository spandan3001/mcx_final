import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {super.key,
      required this.text,
      required this.sender,
      required this.isMe,
      required this.dateTime});
  final String text, sender;
  final bool isMe;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (!isMe)
            Text(
              sender,
              style: const TextStyle(
                fontSize: 10.0,
                color: Colors.black54,
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (isMe)
                Text(
                  DateFormat.jm().format(
                    dateTime,
                  ),
                  style: const TextStyle(fontSize: 12),
                ),
              if (isMe) const SizedBox(width: 5),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.sizeOf(context).width * 0.8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: isMe ? Colors.blue : Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: isMe
                        ? const Radius.circular(0.0)
                        : const Radius.circular(15.0),
                    topLeft: isMe
                        ? const Radius.circular(15.0)
                        : const Radius.circular(0.0),
                    bottomLeft: const Radius.circular(15.0),
                    bottomRight: const Radius.circular(15.0),
                  ),
                ),
                child: Text(
                  text,
                  softWrap: true,
                  style: TextStyle(
                      color: isMe ? Colors.white : Colors.black, fontSize: 12),
                ),
              ),
              if (!isMe) const SizedBox(width: 5),
              if (!isMe)
                Text(
                  DateFormat.jm().format(
                    dateTime,
                  ),
                  style: const TextStyle(fontSize: 12),
                )
            ],
          ),
        ],
      ),
    );
  }
}
