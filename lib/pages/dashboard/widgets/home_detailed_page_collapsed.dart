import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:vibeshot/pages/auth/SignUP/create_account_upload_images.dart';
import '../../../common/theme/app_text_styles.dart';
import '../../../common/theme/colors.dart';
import '../../../common/utility/size_config.dart';
import '../../../model/user_model.dart';

import '../helper/home_helper.dart';
import 'home_crousal_dots.dart';

import 'my_icon_row.dart';

class HomeDetailPage extends StatelessWidget {
  const HomeDetailPage({
    Key? key,
    required this.user,
  }) : super(key: key);
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: const BoxDecoration(
        gradient: AppColors.scaffoldGradient,
      ),
      child: CarouselPage(
        user: user,
      ),
    );
  }
}

class CarouselPage extends StatelessWidget {
  const CarouselPage({
    Key? key,
    required this.user,
  }) : super(key: key);
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Stack(
          children: [
            SlidingUpPanel(
              color: Colors.transparent,
              defaultPanelState: PanelState.CLOSED,
              minHeight: 190,
              maxHeight: Get.height * 0.5,
              body: PageView(
                children: [
                  PictureCard(
                    id: 0,
                    url: HomeHelper.users[0].featuredImage[0],
                    user: user,
                  ),
                  PictureCard(
                    id: 1,
                    url: HomeHelper.users[0].featuredImage[1],
                    user: user,
                  ),
                  PictureCard(
                    id: 2,
                    url: HomeHelper.users[0].featuredImage[2],
                    user: user,
                  ),
                  PictureCard(
                    id: 3,
                    url: HomeHelper.users[0].featuredImage[3],
                    user: user,
                  ),
                ],
              ),
              panel: HomeContent(singleUser: user),
              footer: Container(
                padding: const EdgeInsets.only(
                  bottom: 10,
                  left: 10,
                ),
                child: const Align(
                  child: MyIconRow(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PictureCard extends StatelessWidget {
  const PictureCard({
    Key? key,
    required this.url,
    required this.id,
    required this.user,
  }) : super(key: key);
  final UserModel user;
  final String url;
  final int id;
  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(30.0),
      topRight: Radius.circular(30.0),
    );
    return Stack(
      children: [
        Container(
          height: Get.height,
          width: Get.width,
          margin: const EdgeInsets.fromLTRB(
            20,
            10,
            20,
            0,
          ),
          decoration: BoxDecoration(
            borderRadius: radius,
            image: DecorationImage(
              image: NetworkImage(url),
              fit: BoxFit.cover,
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.borderGrey,
                blurRadius: 2.0,
                spreadRadius: 2.0,
              )
            ],
          ),
        ),
        Positioned(
          top: Get.height * 0.45,
          left: Get.width * 0.4,
          child: HomeCrousalDot(currentIndex: id),
        ),
      ],
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({
    Key? key,
    required this.singleUser,
  }) : super(key: key);
  final UserModel singleUser;
  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(30.0),
      topRight: Radius.circular(30.0),
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 100,
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: radius,
        boxShadow: const [
          BoxShadow(
            color: AppColors.borderGrey,
            blurRadius: 2.0,
            spreadRadius: 2.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const HeightBox(30),
            Text(
              '${singleUser.name}, ${singleUser.age}',
              style: AppTextStyles.profileName,
            ),
            Row(
              children: [
                const Icon(
                  CupertinoIcons.location,
                ),
                const WidthBox(8),
                Text(
                  singleUser.distance,
                  style: AppTextStyles.profileAge,
                ),
              ],
            ),
            const HeightBox(30),
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Text(
                singleUser.shortDescription,
                style: AppTextStyles.profileShortDes,
              ),
            ),
            const HeightBox(40),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                margin: const EdgeInsets.only(right: 40),
                height: getProportionateScreenHeight(109),
                child: Row(
                  children: [
                    const ImageCard(index: 0),
                    WidthBox(
                      getProportionateScreenWidth(10),
                    ),
                    const ImageCard(index: 1),
                    WidthBox(
                      getProportionateScreenWidth(10),
                    ),
                    const ImageCard(index: 2),
                    WidthBox(
                      getProportionateScreenWidth(10),
                    ),
                    const ImageCard(index: 3),
                    WidthBox(
                      getProportionateScreenWidth(10),
                    ),
                  ],
                ),
              ),
            ),
            const HeightBox(40),
            Padding(
              padding: const EdgeInsets.only(
                right: 40,
                bottom: 10,
              ),
              child: Text(
                'About',
                style: AppTextStyles.profileShortDes.copyWith(
                  color: const Color(0xff7B7B7B),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Text(
                singleUser.about,
                style: AppTextStyles.profileShortDes.copyWith(
                  color: const Color(0xff7B7B7B),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const HeightBox(68),
          ],
        ),
      ),
    );
  }
}
