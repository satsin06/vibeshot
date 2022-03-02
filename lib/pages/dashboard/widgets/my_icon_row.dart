import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../common/utility/size_config.dart';
import 'dart:math' as math;
import 'icon_button.dart';

class MyIconRow extends StatelessWidget {
  const MyIconRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth - 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: const MyIconButton(
              icon: Icon(
                CupertinoIcons.refresh,
                color: Color(0xff8B9BA8),
              ),
            ),
          ),
          const WidthBox(25),
          const MyIconButton(
            icon: Icon(
              Icons.favorite,
              color: Color(0xffFF3226),
            ),
          ),
          const WidthBox(25),
          const MyIconButton(
            icon: Icon(
              CupertinoIcons.multiply,
              size: 28,
              color: Color(0xff00B5EE),
            ),
          ),
        ],
      ),
    );
  }
}
