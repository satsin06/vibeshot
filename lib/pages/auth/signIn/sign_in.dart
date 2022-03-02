import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../common/theme/colors.dart';
import 'body.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.scaffoldGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.close_rounded,
                size: 28,
              ),
            ),
            const WidthBox(10)
          ],
        ),
        body: const Body(),
      ),
    );
  }
}
