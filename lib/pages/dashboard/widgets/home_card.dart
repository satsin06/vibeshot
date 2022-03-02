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

import 'home_detailed_page_collapsed.dart';

import 'my_icon_row.dart';

final PanelController controller = PanelController();

class HomeCard extends StatefulWidget {
  const HomeCard({Key? key, required this.user}) : super(key: key);
  final UserModel user;
  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    UserModel singleUser = widget.user;
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(30.0),
      topRight: Radius.circular(30.0),
    );
    double height = SizeConfig.screenHeight;
    return GestureDetector(
      onTap: () => Get.to(
        () => HomeDetailPage(
          user: singleUser,
        ),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: height,
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              singleUser.featuredImage[1],
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: radius,
          boxShadow: [
            BoxShadow(
              color: AppColors.borderGrey.withOpacity(0.7),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: SlidingUpPanel(
          borderRadius: radius,
          maxHeight: SizeConfig.screenHeight * 0.6,
          minHeight: SizeConfig.screenHeight * 0.34,
          parallaxEnabled: false,
          backdropTapClosesPanel: false,
          defaultPanelState: PanelState.CLOSED,
          controller: controller,
          panel: HomeContent(
            singleUser: singleUser,
          ),
          footer: Container(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: const Align(
              child: MyIconRow(),
            ),
          ),
        ),
      ),
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
    return Visibility(
      visible: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const HeightBox(40),
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
              const HeightBox(20),
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
              const HeightBox(48),
            ],
          ),
        ),
      ),
    );
  }
}
