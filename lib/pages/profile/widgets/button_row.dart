import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibeshot/common/utility/route_names.dart';
import 'package:vibeshot/common/utility/simple_preferences.dart';
import 'package:vibeshot/controller/user_list_controller.dart';
import 'package:vibeshot/database/save_likes.dart';
import 'package:vibeshot/networking/profile.dart';
import '../../../common/theme/app_text_styles.dart';
import 'package:get/get.dart';

class MyButtonRow extends StatefulWidget {
  const MyButtonRow({
    Key? key,
  }) : super(key: key);
  @override
  State<MyButtonRow> createState() => _MyButtonRowState();
}

class _MyButtonRowState extends State<MyButtonRow> {
  bool pressed = false;
  final UserListController _userListController = Get.put(UserListController());
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () async {
            SaveLikes saveLikes = SaveLikes.instance;
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            await _userListController.changeShowMoreUsers(true);
            preferences.clear();
            saveLikes.deleteDataBase();
            UserSimplePreferences.deletePhoneNum();
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.welcomeScreen, (Route<dynamic> route) => false);
          },
          child: Container(
            height: 45,
            width: 160,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(36),
            ),
            child: Center(
              child: Text(
                'Log Out',
                style: AppTextStyles.bodyText.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            bool isDeleted = await ProfileApi.deleteUser();
            FirebaseFirestore.instance
                .collection('user')
                .doc(UserSimplePreferences.getPhoneNum().toString())
                .delete();
            print('pressed');
            if (isDeleted) {
              SaveLikes saveLikes = SaveLikes.instance;
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              saveLikes.deleteDataBase();
              await _userListController.changeShowMoreUsers(true);
              preferences.clear();
              UserSimplePreferences.deletePhoneNum();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.welcomeScreen, (Route<dynamic> route) => false);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Error deleting id',
                  ),
                ),
              );
            }
          },
          child: Container(
            height: 45,
            width: 160,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(36),
            ),
            child: Center(
              child: Text(
                'Delete Account',
                style: AppTextStyles.bodyText.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
