import 'package:chat_app/widgets/chat/messages.dart';
import 'package:chat_app/widgets/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    var fbm = FirebaseMessaging.instance;
    fbm.requestPermission();
    FirebaseMessaging.onMessage.listen((msg) {
      print(msg);
      return;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((msg) {
      print(msg);
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterChat'),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: Icon(Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(children: [
                    Icon(
                      Icons.exit_to_app,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 8),
                    const Text('Logout'),
                  ]),
                ),
                value: 'logout',
              )
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
      // StreamBuilder(
      //     stream: FirebaseFirestore.instance
      //         .collection('chats/5p9iqUkEvnBDcZmNIiXh/messages')
      //         .snapshots(),
      //     builder: (ctx, AsyncSnapshot streamSnapshot) {
      //       if (streamSnapshot.connectionState == ConnectionState.waiting) {
      //         return Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       }

      //       final documents = streamSnapshot.data!.docs;
      //       return ListView.builder(
      //         itemCount: documents.length,
      //         itemBuilder: (context, index) => Container(
      //           padding: const EdgeInsets.all(8),
      //           child: Text(documents[index]['text']),
      //         ),
      //       );
      //     }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     FirebaseFirestore.instance
      //         .collection('chats/5p9iqUkEvnBDcZmNIiXh/messages')
      //         .add({'text': 'This was added byclicking the button'});
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}


//  FirebaseFirestore.instance
//               .collection('chats/5p9iqUkEvnBDcZmNIiXh/messages')
//               .snapshots()
//               .listen((data) {
//             print(data.docs[0]['text']);
//           });