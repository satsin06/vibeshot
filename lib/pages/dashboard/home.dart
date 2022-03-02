import 'package:flutter_tinder_swipe/flutter_tinder_swipe.dart';
import 'package:vibeshot/common/theme/app_text_styles.dart';
import 'package:vibeshot/common/theme/colors.dart';
import 'package:vibeshot/common/utility/route_names.dart';
import 'package:vibeshot/common/utility/size_config.dart';
import 'package:vibeshot/common/widgets/app_button.dart';
import 'package:vibeshot/common/widgets/become_a_premium.dart';
import 'package:vibeshot/controller/card_swipe_controller.dart';
import 'package:vibeshot/controller/get_liked_users_controller.dart';
import 'package:vibeshot/controller/matches_controller.dart';
import 'package:vibeshot/controller/user_details_controller.dart';
import 'package:vibeshot/controller/user_list_controller.dart';
import 'package:vibeshot/model/model_user.dart';
import 'package:vibeshot/networking/get_all_users.dart';
import 'package:vibeshot/pages/dashboard/widgets/its_a_match.dart';

import 'helper/profile_helper.dart';
import 'resources/cards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CardSwipeController _cardSwipeController = Get.put(
    CardSwipeController(),
  );
  final UserDetailsController _userDetailsController = Get.put(
    UserDetailsController(),
  );
  final UserListController _userListController = Get.put(
    UserListController(),
  );
  final MatchesController _matchesController = Get.put(
    MatchesController(),
  );
  final LikedUserController _likedUserController =
      Get.put(LikedUserController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _userListController.showMoreUsers.value
          ? SwipeCard(
              animDuration: 300,
              maxWidth: MediaQuery.of(context).size.width,
              maxHeight: MediaQuery.of(context).size.height,
              minWidth: MediaQuery.of(context).size.width * 0.95,
              minHeight: MediaQuery.of(context).size.height * 0.95,
              cardBuilder: (BuildContext context, int index) {
                return _userListController.draggableUserCard.value[index];
              },
              cardController: _cardSwipeController.cardController,
              swipeCompleteCallback:
                  (CardSwipeOrientation orientation, int index) async {
                if (CardSwipeOrientation.RIGHT == orientation) {
                  UserData? user = await GetAllUsers.createLike(
                    _userListController.userList[index].uid,
                  );
                  _matchesController.getMatchUsers();
                  _likedUserController.getLikedUsers();
                  if (user != null) {
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return ItsAMatchPopUp(
                          data: _userListController.userList[index],
                        );
                      },
                    );
                  }
                }

                if (index == _userListController.userList.length - 1) {
                  if (!_userDetailsController.user!.value.isPremium) {
                    _userListController.changeShowMoreUsers(false);
                    showDialog(
                      context: context,
                      builder: (context) => const BecomeAPremiumPopUp(),
                    );
                  } else {
                    await _userListController.getUsers();
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.dashboard);
                    print('refresshing list');
                  }
                }
              },
              swipeUpdateCallback:
                  (DragUpdateDetails details, Alignment align) {},
              totalNum: _userListController.draggableUserCard.length,
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'More Profile will be visible in 24 hours from the time you last scrolled',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.subscribeHeading
                          .copyWith(color: Colors.red),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FloatingActionButton.extended(
                      backgroundColor: AppColors.primaryColor,
                      onPressed: () {},
                      label: Text(
                        'Subscribe for limit free scrolling',
                        style: AppTextStyles.subscribeButton,
                      ),
                    ),
                  ],
                ),
              ),
            );
    });
  }
}
