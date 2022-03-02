import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../pages/auth/helper/helper.dart';
import '../constants/app_constants.dart';
import '../theme/app_text_styles.dart';
import '../theme/colors.dart';

class AboutTextField extends StatelessWidget {
  const AboutTextField({
    required this.controller,
    required this.hint,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Text(
              AuthHelper.About_Me,
              style: AppTextStyles.textfield.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.subtitleText,
              ),
            ),
          ),
          const HeightBox(6),
          TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: 15,
            minLines: 6,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            validator: (value) {
              if (value!.isEmpty) {
                return kNullError;
              } else {
                return null;
              }
            },
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTextStyles.bodyText.copyWith(
                fontSize: 20,
                color: AppColors.borderGrey,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              fillColor: AppColors.textField,
            ),
          ),
        ],
      ),
    );
  }
}
