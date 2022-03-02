import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:vibeshot/common/utility/simple_preferences.dart';
import 'package:vibeshot/controller/age_controller.dart';
import 'package:vibeshot/controller/gender_controller.dart';
import 'package:vibeshot/controller/user_details_controller.dart';
import 'package:vibeshot/pages/auth/otp_verification.dart';

import '../../../common/theme/app_text_styles.dart';
import '../../../common/theme/colors.dart';
import '../../../common/utility/route_names.dart';
import '../../../common/utility/size_config.dart';
import '../../../common/widgets/about_text_field.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_text_field.dart';
import '../../../common/widgets/gender_picker.dart';
import '../helper/helper.dart';
import 'package:get/get.dart';

class CreateAccountName extends StatelessWidget {
  CreateAccountName({
    Key? key,
  }) : super(key: key);

  final AgeController _ageController = Get.put(AgeController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController aboutMeController = TextEditingController();
  final UserDetailsController _userDetailsController =
      Get.put(UserDetailsController());
  final GenderController _genderController = Get.put(GenderController());
  final GlobalKey<FormState> formData = GlobalKey<FormState>();
  // final OtpForm otpForm;

  Future updateUser() async {
    String uid = UserSimplePreferences.getPhoneNum().toString();
    final updateUser = FirebaseFirestore.instance.collection('users').doc(uid);

    final data = {
      'name': nameController.text,
      'age': _ageController.age.value,
      'gender': _genderController.currentGender,
      'about': aboutMeController.text,
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
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Container(
            height: SizeConfig.screenHeight * 0.9,
            width: SizeConfig.screenWidth,
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 20,
            ),
            child: Form(
              key: formData,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppTextField(
                    hintText: AuthHelper.Name,
                    lable: AuthHelper.Name,
                    controller: nameController,
                    // formData: formData,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'Age',
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
                            border: Border.all(
                                color: Colors.grey.shade400, width: 1),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              borderRadius: BorderRadius.circular(10),
                              isExpanded: true,
                              value: _ageController.age.value,
                              onChanged: (int? value) {
                                _ageController.changeAge(value!);
                              },
                              items: _ageController.ages
                                  .map(
                                    (int element) => DropdownMenuItem(
                                      value: element,
                                      child: Text(
                                        element.toString(),
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
                  GenderPicker(),
                  AboutTextField(
                    // formData: formData,
                    hint: 'Enter something about you',
                    controller: aboutMeController,
                  ),
                  AppButton(
                      buttonText: AuthHelper.Continue,
                      onPressed: () {
                        print('name : ' + nameController.text);
                        print('about me: ' + aboutMeController.text);
                        updateUser();
                        print('phone number: ' +
                            UserSimplePreferences.getPhoneNum().toString());
                        // if (nameController.text.isNotEmpty &&
                        //     aboutMeController.text.isNotEmpty) {
                        if (!!formData.currentState!.validate()) {
                          _userDetailsController.getDataFromCreateAccountName(
                            nameController.text,
                            _ageController.age.value,
                            _genderController.currentGender,
                            aboutMeController.text,
                          );
                          Navigator.pushNamed(
                            context,
                            AppRoutes.createAccountIntrestedIn,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Fill all the fields',
                              ),
                            ),
                          );
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 1.5,
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          AuthHelper.Complete_Your_Profile,
          style: AppTextStyles.heading.copyWith(
            fontSize: 18,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            CupertinoIcons.multiply,
            size: 24,
          ),
        ),
        const WidthBox(20),
      ],
    );
  }
}
