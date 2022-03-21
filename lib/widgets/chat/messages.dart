import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('created', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatdocs = chatSnapshot.data.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatdocs.length,
          itemBuilder: (ctx, index) => MessageBubble(
            chatdocs[index]['text'],
            chatdocs[index]['username'],
            chatdocs[index]['userImage'],
            chatdocs[index]['userId'] == user!.uid,
            key: ValueKey(chatdocs[index].id),
          ),
        );
      },
    );
  }
}
