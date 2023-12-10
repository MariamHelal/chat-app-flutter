import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

import '../widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  //const ChatPage({super.key});
  static String id = 'ChatPage';
  final _controler = ScrollController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String name = ModalRoute.of(context)!.settings.arguments as String ;
    var email = ModalRoute.of(context)!.settings.arguments ;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          // print(snapshot.data!['message']);
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            //print(snapshot.data!.docs[2]['message']);
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kLogo,
                      height: 50,
                    ),
                    const Text('Scholar Chat'),
                  ],
                ),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        controller: _controler,
                        itemCount: messagesList.length,
                        itemBuilder: (context, index) {
                          return messagesList[index].id == email
                              ? ChatBubble(
                                  message: messagesList[index],
                                )
                              : ChatBubbleForFriend(
                                  message: messagesList[index],
                                );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add({
                          kMessage: data,
                          kCreatedAt: DateTime.now(),
                          kId: email,
                          'name':name,
                        });
                        controller.clear();
                        _controler.animateTo(
                          0,
                          // _controler.position.maxScrollExtent,
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
                      decoration: InputDecoration(
                        hintText: 'Send Message',
                        suffixIcon: IconButton(
                          color: kPrimaryColor, onPressed: () {  }, icon: const Icon(Icons.send,),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: kPrimaryColor,
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: kPrimaryColor,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Text('Loading...');
          }
        });
  }
}
