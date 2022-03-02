import 'package:flutter/material.dart';
import 'package:vibeshot/common/theme/app_text_styles.dart';
import 'package:vibeshot/common/theme/colors.dart';
import 'package:vibeshot/common/widgets/back_button.dart';
import 'package:vibeshot/pages/auth/SignUP/dummy_data/terms_and%20_Conditions.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.5,
        automaticallyImplyLeading: false,
        leading: MyBackButton(),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Terms and Conditions',
            style: AppTextStyles.heading.copyWith(
              fontSize: 18,
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.scaffoldColor,
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Text(
            terms_and_conditions_text,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
