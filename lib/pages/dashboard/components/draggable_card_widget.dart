// import 'package:flutter/material.dart';
// import 'package:flutter_swipable/flutter_swipable.dart';

// import 'bottom_sheet.dart';
// import 'circular_button_options.dart';
// import 'scrollable_profile_pic.dart';

// class DraggableCardWidget extends StatelessWidget {
//   final String name;
//   final int age;
//   final double miles;
//   final String about;
//   final List<String> intrests;

//   const DraggableCardWidget({
//     Key? key,
//     required this.name,
//     required this.age,
//     required this.miles,
//     required this.about,
//     required this.intrests,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Swipable(
//       child: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: Stack(
//           fit: StackFit.expand,
//           children: [
//             Container(
//               margin: const EdgeInsets.only(
//                 top: 10,
//                 left: 10,
//                 right: 10,
//                 bottom: 0,
//               ),
//               child: const ScrollableProfilePic(
//                 numberOfImages: 4,
//               ),
//             ),
//             DraggableScrollableSheet(
//               initialChildSize: 0.35,
//               maxChildSize: 0.65,
//               minChildSize: 0.35,
//               builder: (
//                 BuildContext context,
//                 ScrollController scrollController,
//               ) {
//                 return ProfileBottomSheet(
//                   name: name,
//                   age: age,
//                   miles: miles,
//                   about: about,
//                   scrollController: scrollController,
//                   interests: intrests,
//                 );
//               },
//             ),
//             Positioned(
//               bottom: 25,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 60),
//                 width: MediaQuery.of(context).size.width,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     CircularButton(
//                         onPressed: () {},
//                         icon: Icons.refresh,
//                         color: Colors.grey.shade500),
//                     CircularButton(
//                         onPressed: () {},
//                         icon: Icons.favorite,
//                         color: Colors.red),
//                     CircularButton(
//                         onPressed: () {},
//                         icon: Icons.clear,
//                         color: Colors.blue),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:vibeshot/controller/card_swipe_controller.dart';

import 'bottom_sheet.dart';
import 'circular_button_options.dart';
import 'scrollable_profile_pic.dart';
import 'package:get/get.dart';

class DraggableCardWidget extends StatelessWidget {
  final String name;
  final int age;
  final double miles;
  final String about;
  final List<String> intrests;
  final List<String> images;
  final CardSwipeController _cardSwipeController = Get.put(
    CardSwipeController(),
  );

  DraggableCardWidget({
    Key? key,
    required this.name,
    required this.age,
    required this.miles,
    required this.about,
    required this.intrests,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: 0,
            ),
            child: ScrollableProfilePic(
              images: images,
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.35,
            maxChildSize: 0.65,
            minChildSize: 0.35,
            builder: (
              BuildContext context,
              ScrollController scrollController,
            ) {
              return ProfileBottomSheet(
                name: name,
                age: age,
                miles: miles,
                about: about,
                scrollController: scrollController,
                interests: intrests,
                imageUrls: images,
              );
            },
          ),
          Positioned(
            bottom: 25,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircularButton(
                    onPressed: () {},
                    icon: Icons.refresh,
                    color: Colors.grey.shade500,
                  ),
                  CircularButton(
                    onPressed: () {
                      _cardSwipeController.swipeRight();
                    },
                    icon: Icons.favorite,
                    color: Colors.red,
                  ),
                  CircularButton(
                    onPressed: () {
                      _cardSwipeController.swipeLeft();
                    },
                    icon: Icons.clear,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
