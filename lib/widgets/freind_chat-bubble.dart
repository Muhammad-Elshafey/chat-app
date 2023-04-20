import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';

import '../constans.dart';

class FriendChatBubble extends StatelessWidget {
  const FriendChatBubble(
      {
        Key? key,
        required this.message
      }
      ) : super(key: key);

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.only(
          left: 16.0 ,
          top: 28.0 ,
          bottom: 28.0 ,
          right: 28.0,
        ),
        decoration: const BoxDecoration(
          color: Color(0xff006D84),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.0),
            bottomLeft: Radius.circular(32.0),
            topRight: Radius.circular(32.0),
          ),
        ),
        child: Text(
          message.message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
