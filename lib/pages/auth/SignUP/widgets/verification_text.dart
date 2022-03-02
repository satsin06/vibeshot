import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../common/theme/app_text_styles.dart';
import '../../helper/helper.dart';

class VerificationText extends StatefulWidget {
  const VerificationText({Key? key}) : super(key: key);

  @override
  State<VerificationText> createState() => _VerificationTextState();
}

class _VerificationTextState extends State<VerificationText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 0, 28, 10),
      child: Text.rich(
        TextSpan(
          text: AuthHelper.Verifiaction_Text,
          children: [
            TextSpan(
              text: AuthHelper.Learn_Number_Changes,
              style: AppTextStyles.bodyText.copyWith(
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => VxToast.show(context, msg: 'Learn More'),
            ),
          ],
        ),
        style: AppTextStyles.bodyText,
        softWrap: true,
        textAlign: TextAlign.center,
      ),
    );
  }
}
