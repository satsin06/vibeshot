import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:vibeshot/common/utility/simple_preferences.dart';
import 'package:vibeshot/controller/intrest_controller.dart';
import 'package:vibeshot/controller/user_details_controller.dart';
import 'package:vibeshot/model/intrest_model.dart';
import 'package:vibeshot/pages/auth/SignUP/dummy_data/intrests_list.dart';

import '../../../common/theme/app_text_styles.dart';
import '../../../common/theme/colors.dart';
import '../../../common/utility/route_names.dart';
import '../../../common/utility/size_config.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/back_button.dart';
import '../helper/helper.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class CreateAccountMyIntrest extends StatefulWidget {
  CreateAccountMyIntrest({Key? key}) : super(key: key);

  @override
  State<CreateAccountMyIntrest> createState() => _CreateAccountMyIntrestState();
}

class _CreateAccountMyIntrestState extends State<CreateAccountMyIntrest> {
  final IntrestController _intrestController = Get.put(IntrestController());

  final UserDetailsController _userDetailsController =
      Get.put(UserDetailsController());

  @override
  void initState() {
    _intrestController.intrests.value.clear();
    super.initState();
  }

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  _updateDeviceToken() async {
    String uid = UserSimplePreferences.getPhoneNum().toString();
    String? fcmToken = await firebaseMessaging.getToken();

    if (fcmToken != null) {
      var tokenRef = firebaseFirestore.collection('users').doc(uid);

      await tokenRef.update({
        'token': fcmToken,
      });
    }
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
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeightBox(getProportionateScreenHeight(20)),
              Text(
                AuthHelper.My_Intrest,
                style: AppTextStyles.heading,
              ),
              HeightBox(getProportionateScreenHeight(20)),
              Text(
                AuthHelper.Intrest_Subtitle,
                style: AppTextStyles.subtitle.copyWith(
                  fontSize: 14,
                  color: AppColors.subtitleText,
                ),
              ),
              HeightBox(getProportionateScreenHeight(20)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Obx(() {
                    return Wrap(
                      runSpacing: getProportionateScreenHeight(10),
                      spacing: getProportionateScreenWidth(10),
                      children: IntrestListClass.intrestList.value
                          .map((content) => MyChip(content: content))
                          .toList(),
                    );
                  }),
                ),
              ),
              const Spacer(),
              AppButton(
                  buttonText: AuthHelper.Submit,
                  onPressed: () async {
                    if (_intrestController.forEdittingProfile) {
                      if (_intrestController.intrests.value.length >= 3) {
                        _userDetailsController.getDatFromCreateAccountMyIntrest(
                            _intrestController.intrests.value);
                        // _userDetailsController.interests!.value =
                        //     _intrestController.intrests.value;
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Choose atleast three interest',
                            ),
                          ),
                        );
                      }
                    } else {
                      if (_intrestController.intrests.value.length >= 3) {
                        String? fcmToken = await firebaseMessaging.getToken();
                        _userDetailsController.getDatFromCreateAccountMyIntrest(
                            _intrestController.intrests.value);
                        _userDetailsController.deviceToken = fcmToken;
                        await _userDetailsController.sendData();
                        print(_userDetailsController.contact);
                        await _userDetailsController
                            .logInUser(_userDetailsController.contact!);

                        if (_userDetailsController.userId != null) {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.createAccountUpload,
                          );
                        } else {
                          Navigator.popUntil(
                            context,
                            ModalRoute.withName(
                              AppRoutes.welcomeScreen,
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Choose atleast three interest',
                            ),
                          ),
                        );
                      }
                    }
                    IntrestListClass.resetIntrest();
                  }),
              HeightBox(getProportionateScreenHeight(40)),
            ],
          ),
        ),
      ),
    );
  }
}

class MyChip extends StatelessWidget {
  MyChip({Key? key, required this.content}) : super(key: key);
  final Intrest content;
  final Color primary = const Color(0xffD9D6D6);
  final IntrestController _intrestController = Get.put(IntrestController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // content.isSelected.value = !content.isSelected.value;
        _intrestController.intrestClicked(content);
      },
      child: Obx(() {
        return Chip(
          elevation: (content.isSelected.value) ? 2 : 0,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          backgroundColor:
              (content.isSelected.value) ? AppColors.primaryColor : primary,
          autofocus: true,
          label: Text(
            content.name,
            style: AppTextStyles.buttonText.copyWith(
              color: (content.isSelected.value) ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
        );
      }),
    );
  }
}
