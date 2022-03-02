import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:vibeshot/common/utility/size_config.dart';
import 'package:vibeshot/common/widgets/app_button.dart';
import 'package:vibeshot/common/widgets/become_a_premium.dart';
import 'package:vibeshot/controller/get_liked_users_controller.dart';
import 'package:vibeshot/controller/user_details_controller.dart';
import 'package:vibeshot/model/model_user.dart';
import 'package:vibeshot/networking/get_all_users.dart';
import 'package:vibeshot/networking/likes_api.dart';
import '../../common/constants/app_constants.dart';
import '../../common/theme/app_text_styles.dart';
import '../../main.dart';
import 'helper/likes_helper.dart';
import 'widgets/likes_card.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LikesPage extends StatelessWidget {
  LikesPage({Key? key}) : super(key: key);
  final UserDetailsController _userDetailsController =
      Get.put(UserDetailsController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: 10,
            ),
            child: Text(
              LikesHelper.LIKE_HEADER,
              style: AppTextStyles.likeHeading,
            ),
          ),
        ),
        Expanded(
          child: LikedUserGrid(),
        ),
      ],
    );
  }
}

class LikedUserGrid extends StatefulWidget {
  LikedUserGrid({
    Key? key,
  }) : super(key: key);

  @override
  State<LikedUserGrid> createState() => _LikedUserGridState();
}

class _LikedUserGridState extends State<LikedUserGrid> {
  final LikedUserController _likedUserController =
      Get.put(LikedUserController());

  final UserDetailsController _userDetailsController =
      Get.put(UserDetailsController());

  @override
  void initState() {
    _likedUserController.getLikedUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return (_likedUserController.isloading.value)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: _likedUserController.likedUserList.value.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: LikesCard(
                        press: (!_userDetailsController.user!.value.isPremium)
                            ? () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      const BecomeAPremiumPopUp(),
                                );
                              }
                            : () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return LikedUserOptions(
                                      likedUser: _likedUserController
                                          .likedUserList[index],
                                    );
                                  },
                                );
                              },
                        image: _likedUserController
                                .likedUserList.value[index].images.isNotEmpty
                            ? _likedUserController
                                .likedUserList.value[index].images[0]
                            : 'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                        title: _likedUserController
                            .likedUserList.value[index].name,
                        age: _likedUserController.likedUserList.value[index].age
                            .toString(),
                        isPremium: _userDetailsController.user!.value.isPremium,
                      ),
                    );
                  },
                ),
              );
      },
    );
  }
}

class LikedUserOptions extends StatelessWidget {
  LikedUserOptions({
    Key? key,
    required UserData likedUser,
  })  : _likedUser = likedUser,
        super(key: key);

  final UserData _likedUser;
  final LikedUserController _likedUserController = Get.put(
    LikedUserController(),
  );

  void showNotification() {
    flutterLocalNotificationsPlugin.show(
        0,
        "VIBESHOT",
        "Someone liked your profile",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  Future<bool> callOnFcmApiSendPushNotifications(
      List<String> deviceToken) async {
    final UserDetailsController _userDetailsController =
        Get.put(UserDetailsController());

    final postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      "registration_ids": [_userDetailsController.deviceToken],
      "collapse_key": "type_a",
      "notification": {
        "title": 'Like',
        "body": 'Some one liked yout profile',
      }
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          "AAAA1IjGP6M:APA91bGaJ33eK4Y-OsjiCJcgmenIFVkrdzNArArh3dsOSNf4q8zYJVjCl9SeoUUSEWBZOBUuEsG5R6wAUGSjJp7GVmfP37C5Wyh0KoyCvG8_f_lY8ke-VJI_cfKUelJtYrwBP-prYL1G" // 'key=YOUR_SERVER_KEY'
    };

    final response = await http.post(Uri.parse(postUrl),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      // on success do sth
      print('test ok push CFM');
      return true;
    } else {
      print(' CFM error');
      // on failure do sth
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(135), horizontal: 40),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 40,
      ),
      height: getProportionateScreenHeight(
        MediaQuery.of(context).size.height * 0.6,
      ),
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xffE5DEFA), Color(0xffffffff)],
        ),
      ),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  _likedUser.images[0],
                ),
              ),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(18),
          ),
          Text(
            _likedUser.aboutMe,
            style: const TextStyle(
              fontSize: 17,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(
              10,
            ),
          ),
          AppButton(
            buttonText: 'Like',
            onPressed: () {
              GetAllUsers.createLike(
                  _likedUser.uid,
                  );
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: getProportionateScreenHeight(
              5,
            ),
          ),
          AppButton(
            buttonText: 'Remove',
            onPressed: () async {
              LikeApi.deleteLike(
                _likedUser.uid,
              );
              await _likedUserController.getLikedUsers();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
