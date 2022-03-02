import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../common/theme/app_text_styles.dart';
import '../../../../common/utility/size_config.dart';
import '../../helper/helper.dart';
import '../../widgets/sign_in_form.dart';
import 'terms_and_condtion.dart';

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
                AuthHelper.Please_Enter_Phone,
                style: AppTextStyles.heading.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const HeightBox(15),
            const SignForm(),
            SizedBox(height: getProportionateScreenHeight(20)),
            const TermsAndCondition()
          ],
        ),
      ),
    );
  }
}
