import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/constants/helper.dart';
import '../../common/theme/app_text_styles.dart';
import '../../common/theme/base.dart';
import '../../common/theme/colors.dart';
import '../../common/utility/route_names.dart';
import '../../common/utility/size_config.dart';
import '../../common/widgets/app_button.dart';
import 'helper/helper.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.scaffoldGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: Stack(
            children: [
              Container(
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AuthHelper.welcomeBackgrondImage),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const HeightBox(10),
                      const AppLogo(),
                      const Spacer(),
                      AppButton(
                        buttonText: AuthHelper.createAccount,
                        onPressed: () => Navigator.pushNamed(
                          context,
                          AppRoutes.createAccountScreen,
                        ),
                      ),
                      const HeightBox(10),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, AppRoutes.signInScreen),
                        borderRadius:
                            BorderRadius.circular(BaseStyles.borderRadius),
                        child: SizedBox(
                          width: getProportionateScreenWidth(323),
                          height: getProportionateScreenHeight(32),
                          child: Center(
                            child: Text(
                              AuthHelper.signIn,
                              style: AppTextStyles.navLinks,
                            ),
                          ),
                        ),
                      ),
                      HeightBox(
                        getProportionateScreenHeight(52),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 45,
          width: 210,
          margin: EdgeInsets.only(
            top: getProportionateScreenHeight(88),
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AuthHelper.appLogo),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Text(
          AppHelper.dummyText.substring(0, 28),
          style: AppTextStyles.logoSubtitle,
        ),
      ],
    );
  }
}
