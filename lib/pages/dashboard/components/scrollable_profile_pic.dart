import 'package:flutter/material.dart';
import 'package:vibeshot/common/utility/size_config.dart';
import 'package:vibeshot/pages/profile/widgets/subscription_crousal.dart';

class ScrollableProfilePic extends StatefulWidget {
  final List<String> images;
  ScrollableProfilePic({Key? key, required this.images}) : super(key: key);

  @override
  State<ScrollableProfilePic> createState() => _ScrollableProfilePicState();
}

class _ScrollableProfilePicState extends State<ScrollableProfilePic> {
  final PageController _pageController = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        (widget.images.isNotEmpty)
            ? PageView.builder(
                onPageChanged: (int? value) {
                  if (value != null) {
                    setState(() {
                      index = value;
                    });
                  }
                },
                controller: _pageController,
                scrollDirection: Axis.vertical,
                itemCount: widget.images.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      if (index < widget.images.length - 1) {
                        _pageController.animateToPage(
                          index + 1,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _pageController.jumpTo(0);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(31),
                          topRight: Radius.circular(
                            31,
                          ),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            widget.images[index],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(31),
                    topRight: Radius.circular(
                      31,
                    ),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                    ),
                  ),
                ),
              ),
        Positioned(
          bottom: getProportionateScreenHeight(270),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Center(
              child: CrousalDot(
                currentIndex: index,
                length: widget.images.length,
              ),
            ),
          ),
        )
      ],
    );
  }
}
