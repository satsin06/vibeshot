import 'package:flutter/material.dart';
import '../../../common/theme/colors.dart';

class HomeCrousalDot extends StatelessWidget {
  const HomeCrousalDot({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: currentIndex,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 10.0,
        child: ListView.builder(
          itemCount: 4,
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
                    color: currentIndex == index
                        ? AppColors.primaryColor
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
