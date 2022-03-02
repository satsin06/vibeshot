import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:vibeshot/common/utility/simple_preferences.dart';
import 'package:vibeshot/controller/matches_controller.dart';
import 'package:vibeshot/controller/user_details_controller.dart';
import 'package:vibeshot/controller/user_list_controller.dart';
import 'package:vibeshot/pages/chat/chatbox.dart';
import 'package:vibeshot/networking/matches_api.dart';
import '../../common/theme/colors.dart';

import '../../common/theme/app_text_styles.dart';
import '../../common/utility/route_names.dart';

import '../../common/widgets/back_button.dart';
import '../../model/matches_model.dart';

import 'widgets/matches_card.dart';
import 'package:get/get.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({Key? key}) : super(key: key);

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  void showConfirmationDialog(
      BuildContext context, String action, VoidCallback onYes) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Warning!!!',
        ),
        content: Text(
          'Do you want to $action',
        ),
        actions: [
          TextButton(onPressed: onYes, child: const Text('Sure')),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('cancel')),
        ],
      ),
    );
  }

  CollectionReference ref = FirebaseFirestore.instance.collection('User');

  bool isSearchBarPresent = false;

  final MatchesController _matchesController = Get.put(MatchesController());

  final UserListController _userListController = Get.put(UserListController());

  final UserDetailsController _userDetailsController =
      Get.put(UserDetailsController());

  final TextEditingController searchName = TextEditingController();

  var currentUser = UserSimplePreferences.getPhoneNum();

  void callChatDetailScreen(
    BuildContext context,
    String matchUid,
    String matchName,
    String matchImage,
  ) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatBox(
                  matchName: matchName,
                  matchImage: matchImage,
                  matchUid: matchUid,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.scaffoldGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Matches',
            style: AppTextStyles.likeHeading,
          ),
          actions: [
            const WidthBox(20),
            IconButton(
              onPressed: () {
                setState(() {
                  isSearchBarPresent = !isSearchBarPresent;
                });
              },
              icon: const Icon(
                Icons.search_rounded,
              ),
            ),
          ],
        ),
        body:

            /// FireStore users
            ///
            // StreamBuilder<QuerySnapshot>(
            //   stream: FirebaseFirestore.instance
            //       .collection('users')
            //       .where('uid', isNotEqualTo: currentUser)
            //       .snapshots(),
            //   builder:
            //       (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //     if (snapshot.hasError) {
            //       return const Center(
            //         child: Text("Something went wrong"),
            //       );
            //     }
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const Center(
            //         child: Text("Loading"),
            //       );
            //     }
            //     if (snapshot.hasData) {
            //       return ListView.builder(
            //           itemCount:
            //               snapshot.hasData ? snapshot.data!.docs.length : 0,
            //           itemBuilder: (_, index) {
            //             return Column(
            //               children: [
            //                 GestureDetector(
            //                   onTap: () => callChatDetailScreen(
            //                       context,
            //                       snapshot.data!.docs[index]['uid'],
            //                       snapshot.data!.docs[index]['name'],
            //                       snapshot.data!.docs[index]['image'][0]),
            //                   child: ListTile(
            //                     // leading: Text('Age: ' +
            //                     //     snapshot.data!.docs[index]['age'].toString()),
            //                     leading: Image.network(
            //                         snapshot.data!.docs[index]['image'][0]),
            //                     title: Text(snapshot.data!.docs[index]['name']),
            //                     subtitle:
            //                         Text(snapshot.data!.docs[index]['about']),
            //                   ),
            //                 ),
            //                 const Divider()
            //               ],
            //             );
            //           });
            //     }
            //     return Container();
            //   },
            // )

            Obx(
          () {
            return (_matchesController.isloading.value)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        isSearchBarPresent
                            ? SizedBox(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: TextField(
                                    controller: searchName,
                                    onChanged: (String value) {
                                      _matchesController.filterUsers(value);
                                    },
                                  ),
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: (isSearchBarPresent)
                              ? MediaQuery.of(context).size.height * 0.78
                              : MediaQuery.of(context).size.height * 0.83,
                          child: Obx(() {
                            return ListView.builder(
                              itemCount: _matchesController.matches.length,
                              itemBuilder: (context, index) =>
                                  FocusedMenuHolder(
                                blurBackgroundColor: Colors.grey[500],
                                menuItems: [
                                  FocusedMenuItem(
                                    title: const Text(
                                      'Pin',
                                    ),
                                    trailingIcon: const Icon(
                                      Icons.push_pin,
                                    ),
                                    onPressed: () {},
                                  ),
                                  FocusedMenuItem(
                                    title: const Text(
                                      'Delete Chat',
                                    ),
                                    trailingIcon: const Icon(
                                      Icons.delete,
                                    ),
                                    onPressed: () {
                                      showConfirmationDialog(
                                          context, 'delete this chat', () {
                                        Navigator.pop(context);
                                      });
                                    },
                                  ),
                                  FocusedMenuItem(
                                    title: const Text(
                                      'Remove match',
                                    ),
                                    trailingIcon: const Icon(
                                      Icons.highlight_off,
                                    ),
                                    onPressed: () {
                                      showConfirmationDialog(
                                        context,
                                        'Remove/Unmatch this person',
                                        () async {
                                          await MatchesApi.deleteMatch(
                                            _matchesController
                                                .matches[index].uid,
                                          );
                                          _matchesController.getMatchUsers();
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                  ),
                                ],
                                onPressed: () {},
                                child: MatchesCard(
                                    match: _matchesController.matches[index],
                                    press: () => callChatDetailScreen(
                                          context,
                                          _matchesController
                                              .matches[index].contact,
                                          _matchesController
                                              .matches[index].name,
                                          _matchesController
                                              .matches[index].images[0],
                                        )
                                    // Navigator.pushNamed(
                                    //   context,
                                    //   AppRoutes.chatPage,
                                    // )
                                    ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
      );
}
