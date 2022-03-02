import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:vibeshot/common/constants/app_constants.dart';
import 'package:vibeshot/common/theme/app_text_styles.dart';
import 'package:vibeshot/common/utility/size_config.dart';

import 'distance_display.dart';

class ProfileBottomSheet extends StatelessWidget {
  final String name;
  final int age;
  final double miles;
  final String about;
  final ScrollController scrollController;
  final List<String> interests;
  final List<String> imageUrls;

  const ProfileBottomSheet({
    Key? key,
    required this.name,
    required this.age,
    required this.miles,
    required this.about,
    required this.scrollController,
    required this.interests,
    required this.imageUrls,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(31),
        ),
      ),
      padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 35,
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color(0xff7B7B7B),
                ),
              ),
            ),
            const HeightBox(20),
            Text(
              '$name, $age',
              style: AppTextStyles.bodyText.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            DistanceDisplayer(
              distance: miles,
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 122,
              child: ListView.builder(
                itemCount: imageUrls.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 90,
                    height: 102,
                    margin:
                        const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      image: DecorationImage(
                        image: NetworkImage(imageUrls[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'About',
              style: AppTextStyles.bodyText.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              about,
              style: AppTextStyles.bodyText.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Interests',
              style: AppTextStyles.bodyText.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // const MyIntrestChip(),
            SizedBox(
              height: 34,
              child: ListView.builder(
                itemCount: interests.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.only(
                      right: 15,
                      top: 5,
                      bottom: 5,
                      left: 15,
                    ),
                    margin: const EdgeInsets.only(right: 5, top: 2, bottom: 2),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.20),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                        child: Text(
                      interests[index],
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  );
                },
              ),
            ),
            const HeightBox(130),
          ],
        ),
      ),
    );
  }
}

class MyIntrestChip extends StatelessWidget {
  const MyIntrestChip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Chip(
            labelPadding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            label: Text(
              'Travel',
              style: TextStyle(
                color: Color(0xffFF816E),
              ),
            ),
            backgroundColor: Color(0xffFFE9E5),
          ),
          Chip(
            labelPadding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            label: Text(
              'Fitness',
              style: TextStyle(
                color: Color(0xffFFA851),
              ),
            ),
            backgroundColor: Color(0xffFFF2E5),
          ),
          Chip(
            labelPadding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            label: Text(
              'Music',
              style: TextStyle(
                color: Color(0xff4CD5FF),
              ),
            ),
            backgroundColor: Color(0xffEBFFFF),
          ),
        ],
      ),
    );
  }
}
