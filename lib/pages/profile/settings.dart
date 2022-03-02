import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:vibeshot/common/utility/route_names.dart';
import 'package:vibeshot/controller/age_range_controller.dart';
import 'package:vibeshot/controller/intrested_in_controller.dart';
import 'package:vibeshot/controller/user_details_controller.dart';
import 'package:vibeshot/pages/auth/SignUP/create_account_intrested_in.dart';
import 'contact_us.dart';
import 'widgets/button_row.dart';
import '../../common/constants/app_constants.dart';
import '../../common/theme/app_text_styles.dart';
import '../../common/theme/colors.dart';
import '../../common/utility/size_config.dart';
import '../../common/widgets/back_button.dart';
import '../dashboard/helper/profile_helper.dart';
import 'widgets/subscription_crousal.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final IntrestedInController _intrestedInController =
      Get.put(IntrestedInController());

  final UserDetailsController _userDetailsController = Get.put(
    UserDetailsController(),
  );

  final AgeRangeController _ageRangeController = Get.put(AgeRangeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      decoration: const BoxDecoration(gradient: AppColors.scaffoldGradient),
      height: SizeConfig.screenHeight,
      child: WillPopScope(
        onWillPop: () async {
          _userDetailsController.user!.value.lookingFor =
              _intrestedInController.lookingFor.value;
          _userDetailsController.user!.value.interestedInGender =
              _intrestedInController.intrest.value;
          _userDetailsController.user!.value.minAge =
              _ageRangeController.lowerRange.toInt();
          _userDetailsController.user!.value.maxAge =
              _ageRangeController.upperRange.toInt();
          _userDetailsController.updateProfile();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 1.5,
            automaticallyImplyLeading: false,
            leading: MyBackButton(
              onPress: () {
                _userDetailsController.user!.value.lookingFor =
                    _intrestedInController.lookingFor.value;
                _userDetailsController.user!.value.interestedInGender =
                    _intrestedInController.intrest.value;
                _userDetailsController.user!.value.minAge =
                    _ageRangeController.lowerRange.toInt();
                _userDetailsController.user!.value.maxAge =
                    _ageRangeController.upperRange.toInt();
                _userDetailsController.updateProfile();
                Navigator.pop(context);
              },
            ),
            title: Text(
              HelperProfile.settings,
              style: AppTextStyles.editImageAppBar,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                (_userDetailsController.user!.value.isPremium)
                    ? Container()
                    : const SubscriptionCrousal(),
                HeightBox(getProportionateScreenHeight(30)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'Are interested in?',
                        textAlign: TextAlign.left,
                        style: AppTextStyles.textfield.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.subtitleText,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(() {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.shade400, width: 1),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            borderRadius: BorderRadius.circular(10),
                            isExpanded: true,
                            value: _intrestedInController.intrest.value,
                            onChanged: (String? value) {
                              _intrestedInController.selectGender(value!);
                            },
                            items: _intrestedInController.intrestCandidate
                                .map(
                                  (String element) => DropdownMenuItem(
                                    value: element,
                                    child: Text(
                                      element,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                HeightBox(getProportionateScreenHeight(20)),
                MySlider(),
                HeightBox(getProportionateScreenHeight(30)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'Looking for?',
                        textAlign: TextAlign.left,
                        style: AppTextStyles.textfield.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.subtitleText,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(() {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.shade400, width: 1),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            borderRadius: BorderRadius.circular(10),
                            isExpanded: true,
                            value: _intrestedInController.lookingFor.value,
                            onChanged: (String? value) {
                              _intrestedInController.changeLookingFor(value!);
                            },
                            items: _intrestedInController.lookingForMap.keys
                                .map(
                                  (String element) => DropdownMenuItem(
                                    value: _intrestedInController
                                        .lookingForMap[element],
                                    child: Text(
                                      element,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                const Divider(
                  thickness: 1.2,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Rewards',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(
                          0xff838383,
                        ),
                      ),
                    ),
                  ),
                ),
                getRewardListItem("The First Reward", (value) {}, false),
                getRewardListItem("The Second Reward", (value) {}, false),
                getRewardListItem("The Third Reward", (value) {}, true),
                getRewardListItem("The Fourth Reward", (value) {}, false),
                getRewardListItem("The Fifth Reward", (value) {}, false),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: const Color(0xff7646F6),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Center(
                      child: Text(
                        'Claim Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1.2,
                ),
                HeightBox(getProportionateScreenHeight(30)),
                const MyItemRow(
                  lable: 'Hide My Profile',
                  isSwitch: true,
                ),
                const MyItemRow(
                  lable: 'Notifications',
                  isSwitch: true,
                ),
                InkWell(
                  onTap: () => Get.to(() => ContactUS()),
                  child: const SizedBox(
                    child: MyItemRow(
                      lable: 'Contact Us',
                    ),
                  ),
                ),
                MyItem(
                  lable: 'Terms & Conditions',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.termsAndCondition);
                  },
                ),
                MyItem(
                  lable: 'Privacy Policy',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.privacyPolicy);
                  },
                ),
                const HeightBox(40),
                const MyButtonRow(),
                const HeightBox(30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyItem extends StatelessWidget {
  const MyItem({
    Key? key,
    required this.lable,
    required this.onTap,
  }) : super(key: key);
  final String lable;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: SizeConfig.screenWidth,
        height: 65,
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  lable,
                  style: AppTextStyles.textfield.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.subtitleText,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    CupertinoIcons.forward,
                    size: 28,
                  ),
                ),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

class MyItemRow extends StatefulWidget {
  const MyItemRow({
    Key? key,
    required this.lable,
    this.onTap,
    this.isSwitch = false,
  }) : super(key: key);
  final String lable;
  final bool isSwitch;
  final Function? onTap;

  @override
  State<MyItemRow> createState() => _MyItemRowState();
}

class _MyItemRowState extends State<MyItemRow> {
  bool val = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.isSwitch) {
          widget.onTap!();
        }
      },
      child: Container(
        width: SizeConfig.screenWidth,
        height: 65,
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.lable,
                  style: AppTextStyles.textfield.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.subtitleText,
                  ),
                ),
                (widget.isSwitch)
                    ? Switch(
                        value: val,
                        onChanged: (value) {
                          setState(() {
                            val = value;
                          });
                        },
                        activeColor: AppColors.primaryColor,
                      )
                    : const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          CupertinoIcons.forward,
                          size: 28,
                        ),
                      ),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

Widget getRewardListItem(
    String rewardText, ValueChanged<bool?>? onTap, bool isChecked) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 30),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          rewardText,
          style: const TextStyle(
              color: Color(0xff838383),
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        Checkbox(
          activeColor: Colors.green,
          value: isChecked,
          onChanged: onTap,
        ),
      ],
    ),
  );
}
