import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:vibeshot/pages/auth/SignUP/dummy_data/terms_and%20_Conditions.dart';

import '../../../../common/theme/app_text_styles.dart';
import '../../helper/helper.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Text.rich(
        TextSpan(
          text: AuthHelper.Agree_Sign_Up,
          children: [
            TextSpan(
              text: AuthHelper.Terms_And_Condition,
              style: AppTextStyles.bodyText.copyWith(
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Terms and Conditions"),
                        content: const SingleChildScrollView(
                          child: Text(
                            terms_and_conditions_text,
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: const Text("OK"),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      );
                    },
                  );
                },
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
