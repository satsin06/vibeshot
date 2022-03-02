import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vibeshot/common/utility/route_names.dart';
import 'package:vibeshot/controller/add_image_controller.dart';
import 'package:vibeshot/controller/age_controller.dart';
import 'package:vibeshot/controller/gender_controller.dart';
import 'package:vibeshot/controller/intrest_controller.dart';
import 'package:vibeshot/controller/user_details_controller.dart';
import 'package:vibeshot/model/intrest_model.dart';
import '../../common/constants/app_constants.dart';
import '../../common/theme/app_text_styles.dart';
import '../../common/theme/colors.dart';
import '../../common/utility/size_config.dart';
import '../../common/widgets/about_text_field.dart';
import '../../common/widgets/app_button.dart';
import '../../common/widgets/app_text_field.dart';
import '../../common/widgets/back_button.dart';
import '../../common/widgets/gender_picker.dart';
import '../auth/helper/helper.dart';
import '../dashboard/helper/profile_helper.dart';
import 'package:get/get.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({Key? key}) : super(key: key);
  final AgeController _ageController = Get.put(AgeController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController aboutMeController = TextEditingController();
  final UserDetailsController _userDetailsController =
      Get.put(UserDetailsController());
  final GenderController _genderController = Get.put(
    GenderController(),
  );
  final IntrestController _intrestController = Get.put(IntrestController());
  final GlobalKey<FormState> formData = GlobalKey<FormState>();

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
            width: SizeConfig.screenWidth,
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppTextField(
                  controller: nameController,
                  hintText: _userDetailsController.name!,
                  lable: AuthHelper.Name,
                ),
                const SizedBox(
                  height: 10,
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
                          border:
                              Border.all(color: Colors.grey.shade400, width: 1),
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
                const SizedBox(
                  height: 10,
                ),
                GenderPicker(),
                const SizedBox(
                  height: 10,
                ),
                AboutTextField(
                  controller: aboutMeController,
                  hint: _userDetailsController.aboutMe ?? '',
                ),
                // const IntrestChip(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Interest',
                        style: AppTextStyles.textfield.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.subtitleText,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          _intrestController.forEdittingProfile = true;
                          _intrestController.intrests.value.clear();
                          await Navigator.pushNamed(
                            context,
                            AppRoutes.createAccountMyIntrest,
                          );
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.editProfile,
                          );
                          _intrestController.forEdittingProfile = false;
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: SizedBox(
                    height: 45,
                    child: Obx(() {
                      return ListView.builder(
                        itemCount:
                            _userDetailsController.interests!.value.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: const EdgeInsets.only(
                              right: 25,
                              top: 5,
                              bottom: 5,
                              left: 25,
                            ),
                            margin: const EdgeInsets.only(
                              right: 20,
                              top: 2,
                              bottom: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.20),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                _userDetailsController
                                    .interests!.value[index].name,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ),
                AppButton(
                  buttonText: 'Update',
                  onPressed: () {
                    if (nameController.text.isNotEmpty) {
                      _userDetailsController.user!.value.name =
                          nameController.text;
                    }
                    _userDetailsController.user!.value.age =
                        _ageController.age.value;
                    _userDetailsController.user!.value.gender =
                        _genderController.currentGender;
                    if (aboutMeController.text.isNotEmpty) {
                      _userDetailsController.user!.value.aboutMe =
                          aboutMeController.text;
                    }
                    _userDetailsController.user!.value.interests =
                        _intrestController.intrests.value
                            .toSet()
                            .map(
                              (Intrest intrest) => intrest.name.toString(),
                            )
                            .toList();
                    _userDetailsController.updateProfile();
                    Navigator.pop(context);
                  },
                )
              ],
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
      centerTitle: true,
      leading: MyBackButton(),
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          'Edit your profile',
          style: AppTextStyles.heading.copyWith(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class IntrestChip extends StatelessWidget {
  const IntrestChip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const IntrestLable(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            width: SizeConfig.screenWidth * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Chip(
                  labelPadding:
                      EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  label: Text(
                    'Travel',
                    style: TextStyle(
                      color: Color(0xffFF816E),
                    ),
                  ),
                  backgroundColor: Color(0xffFFE9E5),
                ),
                Chip(
                  labelPadding:
                      EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  label: Text(
                    'Fitness',
                    style: TextStyle(
                      color: Color(0xffFFA851),
                    ),
                  ),
                  backgroundColor: Color(0xffFFF2E5),
                ),
                Chip(
                  labelPadding:
                      EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  label: Text(
                    'Music',
                    style: TextStyle(
                      color: Color(0xff4CD5FF),
                    ),
                  ),
                  backgroundColor: Color(0xffEBFFFF),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IntrestLable extends StatelessWidget {
  const IntrestLable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding,
      ),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Text(
              'Interests',
              style: AppTextStyles.textfield.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.subtitleText,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.createAccountMyIntrest,
              );
            },
            child: SvgPicture.asset(
              HelperProfile.edit,
            ),
          ),
        ],
      ),
    );
  }
}
