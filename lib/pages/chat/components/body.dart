import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/app_constants.dart';
import '../../../model/chat_message.dart';
import 'chat_input_field.dart';
import 'message.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final ref = FirebaseFirestore.instance.collection('chats').orderBy('chats', descending: false);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          thickness: 2,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: StreamBuilder(
              stream: ref.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return ListView.builder(
                  itemCount: snapshot.hasData ? snapshot.data!.docs.length : 0,
                  itemBuilder: (_, index) =>
                      Message(message: demeChatMessages[index],),
                      //Text(snapshot.data!.docs[index]['chats'])
                );
              }
            ),
          ),
        ),
        ChatInputField(),
      ],
    );
  }
}
