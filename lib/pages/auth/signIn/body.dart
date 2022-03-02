import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../common/theme/app_text_styles.dart';
import '../../../common/theme/colors.dart';
import '../../../common/utility/size_config.dart';
import '../helper/helper.dart';
import '../widgets/no_account_text.dart';
import '../widgets/sign_in_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Text(
                AuthHelper.Welcome_To_Vibeshoot,
                style: AppTextStyles.heading.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                AuthHelper.Whats_Your_PhoneNumber,
                style: AppTextStyles.heading.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.borderGrey,
                ),
              ),
            ),
            const HeightBox(15),
            const SignForm(
              signup: false,
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            const NoAccountText(),
          ],
        ),
      ),
    );
  }
}
