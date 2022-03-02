import 'package:flutter/material.dart';

import '../../../common/theme/colors.dart';

class MyIconButton extends StatelessWidget {
  const MyIconButton({
    Key? key,
    required this.icon,
  }) : super(key: key);
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.borderGrey.withOpacity(0.7),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: icon,
    );
  }
}
