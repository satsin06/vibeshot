import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:vibeshot/controller/user_details_controller.dart';
import '../../common/constants/app_constants.dart';
import '../../common/utility/route_names.dart';
import '../../common/theme/app_text_styles.dart';
import '../../common/theme/colors.dart';
import 'helper/profile_helper.dart';
import '../profile/widgets/subscription_crousal.dart';

import '../../common/utility/size_config.dart';
import 'helper/home_helper.dart';
import 'package:get/get.dart';

class UserProfilePage extends StatefulWidget {
  UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final UserDetailsController _userDetailsController =
      Get.put(UserDetailsController());

  @override
  void initState() {
    _userDetailsController.fillDataInDataBase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: SingleChildScrollView(
        child: Obx(() {
          return Column(
            children: [
              const HeightBox(kDefaultPadding),
              ProfileImage(
                image: _userDetailsController.user!.value.images.isNotEmpty
                    ? _userDetailsController.user!.value.images[0]
                    : 'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
              ),
              const HeightBox(kDefaultPadding / 2),
              Text(
                "${_userDetailsController.user!.value.name}, ${_userDetailsController.user!.value.age}",
                style: AppTextStyles.profileHeadingName,
              ),
              const IconRow(),
              (_userDetailsController.user!.value.isPremium)
                  ? Container()
                  : const SubscriptionCrousal()
            ],
          );
        }),
      ),
    );
  }
}

class IconRow extends StatelessWidget {
  const IconRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: 85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              AppRoutes.settings,
            ),
            child: Column(
              children: [
                SvgPicture.asset(
                  HelperProfile.profleSettings,
                  height: 60,
                ),
                Text(
                  HelperProfile.profileSettingHeading,
                  style: AppTextStyles.profileIcon,
                ),
              ],
            ),
          ),
          const VerticalDivider(
            endIndent: 20,
            indent: 20,
            width: 1,
            color: AppColors.borderGrey,
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              AppRoutes.editProfile,
            ),
            child: Column(
              children: [
                SvgPicture.asset(
                  HelperProfile.profile,
                  height: 60,
                ),
                Text(
                  HelperProfile.profileEditHeading,
                  style: AppTextStyles.profileIcon,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    required this.image,
    Key? key,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.editImages,
      ),
      child: Stack(
        children: [
          CircleAvatar(
            radius: 66,
            backgroundImage: NetworkImage(image),
          ),
          Positioned(
            right: 0,
            top: 8,
            child: SvgPicture.asset(HelperProfile.profileEdit),
          ),
        ],
      ),
    );
  }
}
