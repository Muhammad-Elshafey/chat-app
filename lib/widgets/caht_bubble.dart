import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';

import '../constans.dart';

class ChatBubble extends StatelessWidget {
   ChatBubble(
      {
        Key? key,
        required this.message
      }
      ) : super(key: key);

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.only(
                left: 16.0 ,
                top: 28.0 ,
                bottom: 28.0 ,
                right: 28.0,
            ),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0),
                bottomRight: Radius.circular(32.0),
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
