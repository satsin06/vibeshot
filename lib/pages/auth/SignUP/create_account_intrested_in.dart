import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:another_xlider/another_xlider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:vibeshot/common/utility/simple_preferences.dart';
import 'package:vibeshot/controller/age_controller.dart';
import 'package:vibeshot/controller/age_range_controller.dart';
import 'package:vibeshot/controller/intrested_in_controller.dart';
import 'package:vibeshot/controller/user_details_controller.dart';
import '../../../common/theme/app_text_styles.dart';
import '../../../common/utility/route_names.dart';
import '../../../common/utility/size_config.dart';
import '../../../common/widgets/app_button.dart';

import '../../../common/theme/colors.dart';
import '../../../common/widgets/app_text_field.dart';
import '../../../common/widgets/back_button.dart';
import '../helper/helper.dart';
import 'package:get/get.dart';

class CreateAccountIntrestedIn extends StatelessWidget {
  CreateAccountIntrestedIn({Key? key}) : super(key: key);

  final IntrestedInController _intrestedInController =
      Get.put(IntrestedInController());
  final UserDetailsController _userDetailsController =
      Get.put(UserDetailsController());
  final AgeRangeController _ageRangeController = Get.put(AgeRangeController());

  Future updateUser() async {
    final updateUser = FirebaseFirestore.instance
        .collection('users')
        .doc(UserSimplePreferences.getPhoneNum().toString());

    final data = {
      'intrestedIn': _intrestedInController.intrest.value,
      'minAge': _ageRangeController.lowerRange.value.toInt(),
      'maxAge': _ageRangeController.upperRange.value.toInt(),
      'lookingFor': _intrestedInController.lookingFor.value,
    };

    await updateUser.update(data);
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
          elevation: 1.5,
          leading: MyBackButton(),
        ),
        body: Column(
          children: [
            HeightBox(getProportionateScreenHeight(30)),
            // const AppTextField(
            //   hintText: 'MEN',
            //   lable: AuthHelper.Intrested_In,
            //   inputType: TextInputType.number,
            //   suffix: Icon(
            //     Icons.arrow_drop_down_rounded,
            //     color: AppColors.headingText,
            //   ),
            // ),
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
                      border: Border.all(color: Colors.grey.shade400, width: 1),
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
            // const AppTextField(
            //   hintText: 'Friend',
            //   lable: AuthHelper.Looking_For,
            //   inputType: TextInputType.number,
            //   suffix: Icon(
            //     Icons.arrow_drop_down_rounded,
            //     color: AppColors.headingText,
            //   ),
            // ),
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
                      border: Border.all(color: Colors.grey.shade400, width: 1),
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
            const Spacer(),
            AppButton(
                buttonText: AuthHelper.Continue,
                onPressed: () {
                  print('phone number: ' +
                      UserSimplePreferences.getPhoneNum().toString());
                  updateUser();
                  _userDetailsController.getDataFromCreateAccountIntrestedIn(
                    intrestedIn: _intrestedInController.intrest.value,
                    minAge: _ageRangeController.lowerRange.value.toInt(),
                    maxAge: _ageRangeController.upperRange.value.toInt(),
                    lookingFor: _intrestedInController.lookingFor.value,
                  );
                  Navigator.pushNamed(
                      context, AppRoutes.createAccountMyIntrest);
                }),
            HeightBox(getProportionateScreenHeight(30)),
          ],
        ),
      ),
    );
  }
}

class MySlider extends StatelessWidget {
  final AgeRangeController _ageRangeController = Get.put(AgeRangeController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      height: getProportionateScreenHeight(130),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Text(
              AuthHelper.Age_Range,
              style: AppTextStyles.textfield.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.subtitleText,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Obx(() {
              return Text(
                '${_ageRangeController.lowerRange.value} to ${_ageRangeController.upperRange.value}',
                style: AppTextStyles.heading.copyWith(
                  fontSize: 16,
                ),
              );
            }),
          ),
          SizedBox(
            height: 25,
            child: Obx(() {
              return FlutterSlider(
                values: _ageRangeController.range.value,
                rangeSlider: true,
                max: 60,
                min: 18,
                onDragging: (handlerIndex, lowerValue, upperValue) {
                  _ageRangeController.updateRange(lowerValue, upperValue);
                },
                handler: FlutterSliderHandler(
                  decoration: const BoxDecoration(),
                  child: const CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    radius: 12,
                  ),
                ),
                rightHandler: FlutterSliderHandler(
                  decoration: const BoxDecoration(),
                  child: const CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    radius: 12,
                  ),
                ),
                trackBar: FlutterSliderTrackBar(
                  activeTrackBarHeight: 3,
                  inactiveTrackBarHeight: 3,
                  activeTrackBar: const BoxDecoration(
                    color: AppColors.primaryColor,
                  ),
                  inactiveTrackBar: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.cardGrey,
                    border: Border.all(
                      width: 0.5,
                      color: AppColors.cardGrey,
                    ),
                  ),
                ),
                handlerAnimation: const FlutterSliderHandlerAnimation(
                  curve: Curves.elasticOut,
                  reverseCurve: Curves.bounceIn,
                  duration: Duration(milliseconds: 500),
                  scale: 1.5,
                ),
                tooltip: FlutterSliderTooltip(
                  disabled: true,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
