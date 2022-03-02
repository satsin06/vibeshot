import 'package:flutter/material.dart';
import 'package:vibeshot/common/theme/app_text_styles.dart';
import 'package:vibeshot/common/theme/colors.dart';
import 'package:vibeshot/controller/gender_controller.dart';
import 'package:vibeshot/controller/user_details_controller.dart';

import '../../pages/auth/helper/helper.dart';
import '../theme/app_text_styles.dart';
import '../theme/colors.dart';
import '../utility/size_config.dart';
import 'package:get/get.dart';

class GenderPicker extends StatelessWidget {
  GenderPicker({Key? key}) : super(key: key);

  final GenderController _genderController = Get.put(
    GenderController(),
  );
  final UserDetailsController _userDetailsController = Get.put(
    UserDetailsController(),
  );

  @override
  Widget build(BuildContext context) {
    if (_userDetailsController.gender != null) {
      _genderController.changeGender(
        _userDetailsController.gender == 'Male'
            ? 0
            : _userDetailsController.gender == 'Female'
                ? 1
                : 2,
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      width: SizeConfig.screenWidth,
      height: getProportionateScreenHeight(120),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Text(
              AuthHelper.Gender,
              style: AppTextStyles.textfield.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.subtitleText,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() {
                return GenderCard(
                  type: GenderType.male,
                  isSelected: _genderController.male.value,
                  onTap: () {
                    _genderController.changeGender(0);
                  },
                );
              }),
              Obx(() {
                return GenderCard(
                  type: GenderType.female,
                  isSelected: _genderController.femail.value,
                  onTap: () {
                    _genderController.changeGender(1);
                  },
                );
              }),
              Obx(() {
                return GenderCard(
                  type: GenderType.other,
                  isSelected: _genderController.other.value,
                  onTap: () {
                    _genderController.changeGender(2);
                  },
                );
              }),
            ],
          )
        ],
      ),
    );
  }
}

class GenderCard extends StatelessWidget {
  GenderCard({
    required this.type,
    required this.isSelected,
    required this.onTap,
  });
  final GenderType type;
  final VoidCallback onTap;
  final bool isSelected;
  Color _color = AppColors.headingText;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: getProportionateScreenHeight(84),
        width: getProportionateScreenWidth(100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          color: (isSelected) ? AppColors.primaryColor : AppColors.cardGrey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (type == GenderType.male)
              Icon(
                Icons.male_rounded,
                color: _color,
              )
            else
              (type == GenderType.female)
                  ? Icon(
                      Icons.female_rounded,
                      color: _color,
                    )
                  : Icon(
                      Icons.transgender_rounded,
                      color: _color,
                    ),
            if (type == GenderType.male)
              Text(
                'Male',
                style: AppTextStyles.bodyText.copyWith(color: _color),
              )
            else
              (type == GenderType.female)
                  ? Text(
                      'Female',
                      style: AppTextStyles.bodyText.copyWith(color: _color),
                    )
                  : Text(
                      'Other',
                      style: AppTextStyles.bodyText.copyWith(color: _color),
                    )
          ],
        ),
      ),
    );
  }
}

enum GenderType { male, female, other }

// class GenderPicker extends StatelessWidget {
//   GenderPicker({Key? key}) : super(key: key);

//   final GenderController _genderController = Get.put(GenderController());
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30),
//           child: Text(
//             'Gender',
//             textAlign: TextAlign.left,
//             style: AppTextStyles.textfield.copyWith(
//               fontSize: 20,
//               fontWeight: FontWeight.w600,
//               color: AppColors.subtitleText,
//             ),
//           ),
//         ),
//         const SizedBox(height: 10),
//         Obx(() {
//           return Container(
//             margin: const EdgeInsets.symmetric(horizontal: 25),
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey.shade400, width: 1),
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             width: MediaQuery.of(context).size.width,
//             child: DropdownButtonHideUnderline(
//               child: DropdownButton<String>(
//                 borderRadius: BorderRadius.circular(10),
//                 isExpanded: true,
//                 value: _genderController.gender.value,
//                 onChanged: (String? value) {
//                   _genderController.selectGender(value!);
//                 },
//                 items: _genderController.genders
//                     .map(
//                       (String element) => DropdownMenuItem(
//                         value: element,
//                         child: Text(
//                           element,
//                         ),
//                       ),
//                     )
//                     .toList(),
//               ),
//             ),
//           );
//         }),
//       ],
//     );
//   }
// }
