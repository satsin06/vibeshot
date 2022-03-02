import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../common/constants/app_constants.dart';
import '../../../common/theme/app_text_styles.dart';
import '../../../common/theme/colors.dart';

class LikesCard extends StatelessWidget {
  const LikesCard(
      {Key? key,
      required this.image,
      required this.title,
      required this.age,
      required this.isPremium,
      this.press})
      : super(key: key);

  final String image, title, age;

  final bool isPremium;

  final Function()? press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Stack(
        children: [
          Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width / 2.3,
                decoration: BoxDecoration(
                  color: AppColors.scaffoldColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 3),
                      blurRadius: 3,
                      color: AppColors.primaryColor.withOpacity(0.23),
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.3,
                height: 70,
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 3),
                      blurRadius: 3,
                      color: AppColors.primaryColor.withOpacity(0.23),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      title,
                      style: AppTextStyles.likeCardName,
                    ),
                    Text(
                      '$age years old',
                      style: AppTextStyles.likeCardAge,
                    ),
                  ],
                ),
              )
            ],
          ),
          (!isPremium)
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  height: (MediaQuery.of(context).size.height / 5) + 70,
                  width: MediaQuery.of(context).size.width / 2.3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5.0,
                        sigmaY: 5.0,
                        tileMode: TileMode.repeated,
                      ),
                      child: Container(),
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
