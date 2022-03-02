import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../constants/app_constants.dart';
import '../theme/app_text_styles.dart';
import '../theme/colors.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    Key? key,
    required this.hintText,
    required this.lable,
    required this.controller,
    this.suffix,
    this.inputType = TextInputType.name,
  }) : super(key: key);
  final Widget? suffix;
  final String hintText;
  final String lable;
  final TextInputType inputType;
  final TextEditingController controller;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool isError = false;

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
              widget.lable,
              style: AppTextStyles.textfield.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.subtitleText,
              ),
            ),
          ),
          const HeightBox(6),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: widget.inputType,
            controller: widget.controller,
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  isError = false;
                });
              } else {
                setState(() {
                  isError = true;
                });
              }
            },
            validator: (value) {
              if (value!.isEmpty) {
                return kNullError;
              }
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppTextStyles.bodyText.copyWith(
                color: AppColors.borderGrey,
              ),
              suffixIcon: widget.suffix ?? const SizedBox.shrink(),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              fillColor: (!isError)
                  ? AppColors.textField
                  : AppColors.textFieldError.withOpacity(0.14),
            ),
          ),
        ],
      ),
    );
  }
}
