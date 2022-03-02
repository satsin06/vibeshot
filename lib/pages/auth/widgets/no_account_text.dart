import 'package:flutter/material.dart';

import '../../../common/theme/app_text_styles.dart';
import '../../../common/utility/route_names.dart';
import '../../../common/utility/size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: AppTextStyles.bodyText
              .copyWith(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, AppRoutes.createAccountScreen),
          child: Text(
            "Sign Up",
            style: AppTextStyles.navLinks
                .copyWith(decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}
