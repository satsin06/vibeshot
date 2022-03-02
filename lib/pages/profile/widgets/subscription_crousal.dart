import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../common/constants/app_constants.dart';
import '../../../common/theme/app_text_styles.dart';
import '../../../common/theme/colors.dart';
import '../../../common/utility/size_config.dart';
import '../../../model/subscription_model.dart';
import '../../dashboard/helper/profile_helper.dart';

class SubscriptionCrousal extends StatefulWidget {
  const SubscriptionCrousal({Key? key}) : super(key: key);

  @override
  _SubscriptionCrousalState createState() => _SubscriptionCrousalState();
}

class _SubscriptionCrousalState extends State<SubscriptionCrousal> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: SizeConfig.screenWidth,
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding,
      ),
      child: Column(
        children: [
          Text(
            subscription[0].text,
            textAlign: TextAlign.center,
            style: AppTextStyles.subscribeHeading,
          ),
          const HeightBox(10),
          CrousalDot(currentIndex: currentIndex, length: subscription.length,),
          const HeightBox(10),
          SizedBox(
            height: 290,
            width: MediaQuery.of(context).size.width,
            child: PageView.builder(
              itemCount: subscription.length,
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, index) {
                return CrousalBody(
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CrousalDot extends StatelessWidget {
  const CrousalDot({
    Key? key,
    required this.currentIndex,
    required this.length,
  }) : super(key: key);

  final int currentIndex;
  final int length;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.0,
      child: ListView.builder(
        itemCount: length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 3.0),
                width: currentIndex == index ? 25 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CrousalBody extends StatelessWidget {
  const CrousalBody({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.borderGrey.withOpacity(0.4),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            subscription[index].desc,
            textAlign: TextAlign.center,
            style: AppTextStyles.subscribeDes,
          ),
          Text(
            subscription[index].time,
            textAlign: TextAlign.center,
            style: AppTextStyles.subscribeTime,
          ),
          Text(
            subscription[index].price,
            textAlign: TextAlign.center,
            style: AppTextStyles.subscribePrice,
          ),
          FloatingActionButton.extended(
            backgroundColor: AppColors.primaryColor,
            onPressed: () =>
                VxToast.show(context, msg: HelperProfile.subscribe),
            label: Text(
              HelperProfile.subscribe,
              style: AppTextStyles.subscribeButton,
            ),
          ),
        ],
      ),
    );
  }
}
