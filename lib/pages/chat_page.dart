import 'package:chat_app/constans.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/freind_chat-bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/caht_bubble.dart';

class ChatPage extends StatelessWidget {

  static String id = 'chat page';
  final ScrollController _controller = ScrollController();
  TextEditingController messageSentController = TextEditingController();
  CollectionReference messages = FirebaseFirestore.instance.collection(
      kMessageCollectionReference
  );
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt , descending: true).snapshots(),
      builder: (context ,snapshot)
      {
        List<Message> messageList= [];
        for(int i=0 ; i < snapshot.data!.docs.length; i++)
          {
            messageList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
        if(snapshot.hasData)
          {
             return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    Image.asset(kLogo, height: 50),
                    const SizedBox(width: 5,),
                    const Text('Chat'),
                  ],
                ),
                centerTitle: true,
                backgroundColor: kPrimaryColor,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messageList.length,
                        itemBuilder: (context , index)
                        {
                          return messageList[index].id == email ? ChatBubble(
                            message: messageList[index],
                          ) : FriendChatBubble(
                              message: messageList[index],
                          );
                        }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: 12.0,
                      top: 10.0,
                    ),
                    //symmetric(horizontal: 16.0 , vertical: 12.0),
                    child: TextFormField(
                      controller: messageSentController,
                      onFieldSubmitted: (data)
                      {
                        messages.add({
                          kMessage:data,
                          kCreatedAt: DateTime.now(),
                          'id' : email,
                        });
                        messageSentController.clear();
                        _controller.animateTo(
                          0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
                      decoration: InputDecoration(
                        hintText: 'Send Message',
                        suffixIcon: Icon(
                            Icons.send ,
                            color: kPrimaryColor
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        else
          {
            return const Text('Loading...');
          }
      },
    );
  }
}
