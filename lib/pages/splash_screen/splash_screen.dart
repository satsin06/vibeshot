import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibeshot/common/theme/colors.dart';
import 'package:vibeshot/common/utility/route_names.dart';
import 'package:vibeshot/common/utility/size_config.dart';
import 'package:vibeshot/controller/get_liked_users_controller.dart';
import 'package:vibeshot/controller/like_count_controller.dart';
import 'package:vibeshot/controller/user_details_controller.dart';
import 'package:vibeshot/controller/user_list_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final UserListController _userListController = Get.put(
    UserListController(),
  );
  final UserDetailsController _userDetailsController = Get.put(
    UserDetailsController(),
  );

  void getUserList(BuildContext context) async {
    final LikeCountController _likeCountController = Get.put(
      LikeCountController(),
    );
    final LikedUserController _likedUserController = Get.put(
      LikedUserController(),
    );
    try {
      await _userDetailsController.fillDataInDataBase();
      await _likedUserController.getLikedUsers();
      bool userListisLoaded = await _userListController.getUsers();
      if (userListisLoaded) {
        Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'unable to update user list',
            ),
          ),
        );
        Navigator.pushReplacementNamed(context, AppRoutes.welcomeScreen);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Login expired!!! login again',
          ),
        ),
      );
      Navigator.pushReplacementNamed(context, AppRoutes.welcomeScreen);
    }
  }

  void isUserLogesIn(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        String? userId = sharedPreferences.getString("userid");
        String? authToken = sharedPreferences.getString("authorization");

        if (userId != null && authToken != null) {
          getUserList(context);
        } else {
          Navigator.pushReplacementNamed(context, AppRoutes.welcomeScreen);
        }
      }
    } on SocketException catch (_) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('ERROR'),
          content: const Text(
            'No Internet connection',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'OK',
              ),
            )
          ],
        ),
      );
      Timer(const Duration(seconds: 5), () => exit(0) );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    isUserLogesIn(context);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: AppColors.scaffoldGradient,
        ),
        child: const Center(
          child: Text(
            'VibeShort',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
