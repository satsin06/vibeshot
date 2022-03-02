import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:vibeshot/common/constants/app_constants.dart';
import 'package:vibeshot/common/theme/app_text_styles.dart';
import 'package:vibeshot/common/theme/colors.dart';
import 'package:vibeshot/common/utility/simple_preferences.dart';
import 'package:vibeshot/common/utility/size_config.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class ChatBox extends StatefulWidget {
  String matchUid;
  String matchName;
  String matchImage;
  ChatBox(
      {Key? key,
      required this.matchUid,
      required this.matchName,
      required this.matchImage})
      : super(key: key);

  @override
  _ChatBoxState createState() => _ChatBoxState(matchUid, matchName, matchImage);
}

class _ChatBoxState extends State<ChatBox> {
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  final matchUid;
  final matchName;
  final matchImage;
  var chatDocId;
  var _textController = TextEditingController();
  final currentUserId = UserSimplePreferences.getPhoneNum();
  final image = FirebaseFirestore.instance
      .collection('User')
      .doc(UserSimplePreferences.getPhoneNum())
      .collection('image'[0])
      .snapshots();

  _ChatBoxState(this.matchUid, this.matchName, this.matchImage);
  @override
  void initState() {
    super.initState();
    checkUser();
    OneSignal.shared.setLogLevel(OSLogLevel.debug, OSLogLevel.none);
    OneSignal.shared.setAppId('24c86371-d015-4c69-a21a-3b35c932f583');
  }

  void checkUser() async {
    await chats
        .where('users', isEqualTo: {matchUid: null, currentUserId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) async {
          if (querySnapshot.docs.isNotEmpty) {
            setState(() {
              chatDocId = querySnapshot.docs.single.id;
            });
          } else {
            await chats.add({
              'users': {matchUid: null, currentUserId: null}
            }).then((value) => {chatDocId = value});
          }
        })
        .catchError((error) {});
  }

  bool isSender(String match) {
    return match == currentUserId;
  }

  Alignment getAlignment(friend) {
    if (friend == currentUserId) {
      return Alignment.topRight;
    }
    return Alignment.topLeft;
  }

  String formattedDate = DateFormat('kk:mm').format(DateTime.now());

  void sendMessage(String message) {
    if (message == '') return;
    chats.doc(chatDocId).collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'time': formattedDate,
      'uid': currentUserId,
      'message': message
    }).then((value) {
      _textController.text = '';
    });
  }

  Future<http.Response> sendNotification(
      List<String> tokenIdList, String contents, String heading) async {
    return await http.post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "app_id": '24c86371-d015-4c69-a21a-3b35c932f583',

        "include_player_ids": tokenIdList,

        // android_accent_color reprsent the color of the heading text in the notifiction
        "android_accent_color": "FF9976D2",

        "small_icon": "ic_stat_onesignal_default",

        "large_icon":
            "https://www.gstatic.com/mobilesdk/160503_mobilesdk/logo/2x/firebase_28dp.png",

        "headings": {"en": heading},

        "contents": {"en": contents},
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              child: const Padding(
                padding: EdgeInsets.only(
                  right: 12,
                ),
                child: Icon(Icons.arrow_back_ios_new_rounded),
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
            CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.primaryColor,
              backgroundImage: NetworkImage(
                matchImage,
              ),
            ),
            const SizedBox(width: kDefaultPadding * 0.75),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  matchName,
                  style: AppTextStyles.chatName,
                ),
                Text(
                  "Online",
                  style: AppTextStyles.chatStatus,
                )
              ],
            )
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert_outlined,
              size: 28,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: kDefaultPadding / 2),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: chats
            .doc(chatDocId)
            .collection('messages')
            .orderBy('createdOn', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("Loading"),
            );
          }
          if (snapshot.hasData) {
            var data;
            return SafeArea(
                child: Column(
              children: [
                Expanded(
                    child: ListView(
                  reverse: true,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    data = document.data()!;
                    return Padding(
                      padding: const EdgeInsets.only(top: kDefaultPadding),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 28.0, right: 28, bottom: 16),
                        child: Row(
                          mainAxisAlignment: isSender(data['uid'].toString())
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          crossAxisAlignment: isSender(data['uid'].toString())
                              ? CrossAxisAlignment.center
                              : CrossAxisAlignment.end,
                          children: [
                            isSender(data['uid'].toString())
                                ? Material(
                                    shadowColor: AppColors.primaryColor,
                                    color: AppColors.primaryColor,
                                    type: MaterialType.canvas,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(24),
                                      topRight: Radius.circular(24),
                                      bottomRight: Radius.circular(24),
                                      bottomLeft: Radius.circular(24),
                                    ),
                                    elevation: 3,
                                    child: Container(
                                      width: SizeConfig.screenWidth * 0.7,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: kDefaultPadding,
                                        vertical: kDefaultPadding - 5,
                                      ),
                                      decoration: const BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(24),
                                          topRight: Radius.circular(24),
                                          bottomLeft: Radius.circular(24),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data['message'].toString(),
                                            style: AppTextStyles.chatSent,
                                          ),
                                          const HeightBox(6),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Text(
                                              data['time'] ?? formattedDate,
                                              style: AppTextStyles.chatSentTime,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 24,
                                        backgroundImage:
                                            NetworkImage(matchImage),
                                      ),
                                      const SizedBox(
                                          width: kDefaultPadding / 2),
                                      Material(
                                        shadowColor: AppColors.primaryColor,
                                        color: Colors.white,
                                        type: MaterialType.canvas,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(24),
                                          topRight: Radius.circular(24),
                                          bottomRight: Radius.circular(24),
                                        ),
                                        elevation: 3,
                                        child: Container(
                                          width: SizeConfig.screenWidth * 0.7,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: kDefaultPadding,
                                            vertical: kDefaultPadding - 5,
                                          ),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(24),
                                              topRight: Radius.circular(24),
                                              bottomRight: Radius.circular(24),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data['message'].toString(),
                                                style:
                                                    AppTextStyles.chatRecived,
                                              ),
                                              const HeightBox(6),
                                              Text(
                                                data['time'] ?? formattedDate,
                                                style: AppTextStyles.chatTime,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                )),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                    vertical: kDefaultPadding / 2,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 4),
                        blurRadius: 32,
                        color: const Color(0xFF087949).withOpacity(0.08),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding * 0.75,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.sentiment_satisfied_alt_outlined,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color!
                                    .withOpacity(0.64),
                              ),
                              const SizedBox(width: kDefaultPadding / 2),
                              Expanded(
                                  child: TextField(
                                textCapitalization:
                                    TextCapitalization.sentences,
                                controller: _textController,
                                autocorrect: true,
                                enableSuggestions: true,
                                decoration: const InputDecoration(
                                  hintText: "Type message",
                                  border: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  filled: false,
                                ),
                                // onTap: () {
                                //   sendMessage(_textController.text);
                                //   sendNotification([
                                //     'cVY-4xoZQ6edQdy8ZbW1LA:APA91bG76ZmjYRIRTNjyFevQYx8ynb_gKObYgoEyHcakM1OlBFp6kg-QP3SPg4xhLF9MdCSjaUsVpXsgdljSZL1u-ANchpMjydYbT-Vm-CsDSi14QaxeSlKaJHxQQmewC3Wcjyz0knW-'
                                //   ], 'contents', 'heading');
                                // },
                                textInputAction: TextInputAction.next,
                                onSubmitted: sendMessage,
                              )),
                              const SizedBox(width: kDefaultPadding / 4),
                              InkWell(
                                onTap: () => sendNotification([
                                    'cVY-4xoZQ6edQdy8ZbW1LA:APA91bG76ZmjYRIRTNjyFevQYx8ynb_gKObYgoEyHcakM1OlBFp6kg-QP3SPg4xhLF9MdCSjaUsVpXsgdljSZL1u-ANchpMjydYbT-Vm-CsDSi14QaxeSlKaJHxQQmewC3Wcjyz0knW-'
                                  ], 'contents', 'heading'),
                                child: Container(
                                  height: 46,
                                  width: 46,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(26),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: kDefaultPadding / 4),
                              Container(
                                height: 46,
                                width: 46,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(26),
                                ),
                                child: const Icon(
                                  Icons.mic,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ],
            ));
          }
          return Container();
        },
      ),
    );
  }
}
