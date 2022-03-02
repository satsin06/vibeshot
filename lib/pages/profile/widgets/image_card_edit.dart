import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vibeshot/controller/add_image_controller.dart';
import '../../../common/utility/size_config.dart';
import '../../dashboard/helper/home_helper.dart';
import 'dart:io';

// class ImageCardEdit extends StatelessWidget {
//   const ImageCardEdit({Key? key, this.isImage = false}) : super(key: key);
//   final bool isImage;
//   @override
//   Widget build(BuildContext context) {
//     return WithImage();
//   }
// }

// class NoImage extends StatelessWidget {
//   NoImage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: SizeConfig.screenHeight * 0.3,
//       width: SizeConfig.screenWidth * 0.4,
//       child: Stack(
//         children: [
//           Container(
//             height: SizeConfig.screenHeight * 0.3,
//             width: SizeConfig.screenWidth * 0.4,
//             decoration: BoxDecoration(
//               color: const Color(0xffE8E5E5),
//               borderRadius: BorderRadius.circular(30),
//             ),
//           ),
//           Positioned(
//             right: 0,
//             bottom: 0,
//             child: Container(
//               height: 45,
//               width: 45,
//               decoration: const BoxDecoration(
//                 color: Color(0xffF6564C),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   bottomRight: Radius.circular(30),
//                 ),
//               ),
//               child: const Icon(
//                 Icons.add,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class WithImage extends StatelessWidget {
  final String imageUrl;

  WithImage(this.imageUrl);

  final AddImageController _addImageController = Get.put(AddImageController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      child: SizedBox(
        height: SizeConfig.screenHeight * 0.3,
        width: SizeConfig.screenWidth * 0.4,
        child: Stack(
          children: [
            Container(
              height: SizeConfig.screenHeight * 0.3,
              width: SizeConfig.screenWidth * 0.4,
              decoration: BoxDecoration(
                color: const Color(0xffE8E5E5),
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(imageUrl),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                  height: 45,
                  width: 45,
                  decoration: const BoxDecoration(
                    color: Color(0xffF6564C),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      bool isDone =
                          await _addImageController.deleteImage(imageUrl);
                      if (!isDone) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Must have atleast one account in account',
                            ),
                          ),
                        );
                      }
                    },
                    icon: const Icon(
                      CupertinoIcons.multiply,
                      color: Colors.white,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
