import 'package:flutter/material.dart';

import '../theme/app_text_styles.dart';
import '../theme/base.dart';
import '../theme/colors.dart';
import '../theme/inner_shadow.dart';
import '../utility/size_config.dart';

class AppButton extends StatefulWidget {
  final String buttonText;

  final void Function() onPressed;

  const AppButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);
  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 20),
      padding: EdgeInsets.only(
        top: (pressed)
            ? BaseStyles.listFieldVertical + BaseStyles.animationOffset
            : BaseStyles.listFieldVertical,
        bottom: (pressed)
            ? BaseStyles.listFieldVertical - BaseStyles.animationOffset
            : BaseStyles.listFieldVertical,
        left: BaseStyles.listFieldHorizontal,
        right: BaseStyles.listFieldHorizontal,
      ),
      child: Container(
        width: getProportionateScreenWidth(323),
        height: getProportionateScreenHeight(52),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(BaseStyles.borderRadius),
          boxShadow: const [
            BoxShadow(
              blurRadius: 6,
              color: AppColors.outerShadow,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: GestureDetector(
          onTapDown: (details) {
            setState(() {
              pressed = !pressed;
            });
          },
          onTapUp: (details) {
            setState(() {
              pressed = !pressed;
            });
          },
          onTap: () {
            widget.onPressed();
          },
          child: InnerShadow(
            blur: 6,
            color: AppColors.innerShadow,
            offset: const Offset(0, 3),
            key: const ValueKey('app_button'),
            child: Container(
              width: getProportionateScreenWidth(323),
              height: getProportionateScreenHeight(52),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(BaseStyles.borderRadius),
              ),
              child: Text(
                widget.buttonText,
                style: AppTextStyles.buttonText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
