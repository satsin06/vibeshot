import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vibeshot/controller/get_liked_users_controller.dart';
import 'package:vibeshot/controller/like_count_controller.dart';

import '../../common/theme/colors.dart';
import '../../common/utility/size_config.dart';
import 'helper/dashboard_helper.dart';
import 'home.dart';
import 'likes.dart';
import 'matches.dart';
import 'user_profile.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);
  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  int cureentIndex = 0;
  final LikeCountController _likeCountController = Get.put(
    LikeCountController(),
  );
  final LikedUserController _likedUserController = Get.put(
    LikedUserController(),
  );

  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = (_likedUserController.likedUserList.length -
                _likeCountController.likeCount.value) >
            0
        ? [
            Tab(
              icon: tabIcon(
                path: DashBoardHelper.homeIcon,
                index: 0,
              ),
            ),
            Tab(
              child: Stack(
                children: [
                  tabIcon(
                    path: DashBoardHelper.likeIcon,
                    index: 1,
                  ),
                  Text(
                    '${_likedUserController.likedUserList.length - _likeCountController.likeCount.value}',
                  )
                ],
              ),
            ),
            Tab(
              icon: tabIcon(
                path: DashBoardHelper.matchesIcon,
                index: 2,
              ),
            ),
            Tab(
              icon: tabIcon(
                path: DashBoardHelper.profileIcon,
                index: 3,
              ),
            ),
            // Tab(
            //   icon: Icon(Icons.chat)
            // ),
          ]
        : [
            Tab(
              icon: tabIcon(
                path: DashBoardHelper.homeIcon,
                index: 0,
              ),
            ),
            Tab(
              icon: tabIcon(
                path: DashBoardHelper.likeIcon,
                index: 1,
              ),
            ),
            Tab(
              icon: tabIcon(
                path: DashBoardHelper.matchesIcon,
                index: 2,
              ),
            ),
            Tab(
              icon: tabIcon(
                path: DashBoardHelper.profileIcon,
                index: 3,
              ),
            ),
            // Tab(
            //   icon: Icon(Icons.chat)
            // ),
          ];
    return DefaultTabController(
      length: tabs.length,
      initialIndex: 0,
      child: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.scaffoldGradient,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: (SizeConfig.screenWidth <= 420)
                      ? SizeConfig.screenWidth
                      : 420,
                  child: TabBar(
                    tabs: tabs,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 2,
                    indicatorColor: AppColors.primaryColor,
                    isScrollable: false,
                    unselectedLabelColor: AppColors.borderGrey,
                    labelColor: AppColors.primaryColor,
                    onTap: (index) {
                      setState(() {
                        cureentIndex = index;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const HomePage(),
              LikesPage(),
              const MatchesPage(),
              UserProfilePage(),
              //Messaging(user: User.,)
            ],
          ),
        ),
      ),
    );
  }

  Widget tabIcon({String? path, int? index}) {
    return SizedBox(
      width: getProportionateScreenWidth(30),
      height: getProportionateScreenHeight(30),
      child: SvgPicture.asset(
        path!,
        color: (cureentIndex == index)
            ? AppColors.primaryColor
            : AppColors.borderGrey,
      ),
    );
  }
}
