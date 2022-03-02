import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:vibeshot/controller/add_image_controller.dart';
import 'package:vibeshot/controller/user_details_controller.dart';
import 'package:vibeshot/networking/profile.dart';
import '../../common/constants/app_constants.dart';
import '../../common/theme/app_text_styles.dart';
import '../../common/theme/colors.dart';
import '../../common/utility/size_config.dart';
import '../../common/widgets/back_button.dart';
import '../dashboard/helper/profile_helper.dart';
import 'widgets/image_card_edit.dart';
import 'package:get/get.dart';

class EditImagesPage extends StatelessWidget {
  EditImagesPage({Key? key}) : super(key: key);

  final AddImageController _addImageController = Get.put(AddImageController());

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
          leading: MyBackButton(
            onPress: () async {
              bool hasUpdated = await ProfileApi.uploadPhotos(
                  _addImageController.imagesUrl.value);
              if (hasUpdated) {
                print("Updated in API");
                Navigator.pop(context);
              } else {
                print("Error while updating");
              }
            },
          ),
          title: Text(
            HelperProfile.editImages,
            style: AppTextStyles.editImageAppBar,
          ),
        ),
        body: Obx(() {
          return ModalProgressHUD(
            inAsyncCall: _addImageController.isUploading.value,
            child: GridView.builder(
              itemCount: _addImageController.imagesUrl.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return WithImage(
                  _addImageController.imagesUrl[index],
                );
              },
            ),
          );
        }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink.shade300,
          onPressed: () {
            if (_addImageController.imagesUrl.length < 6) {
               _addImageController.singleImageUpload();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('You can upload only 6 images'),
                ),
              );
            }
          },
          child: const Icon(Icons.add),
        ),
        // body: SingleChildScrollView(
        //   child: Container(
        //     width: SizeConfig.screenWidth,
        //     padding: const EdgeInsets.all(kDefaultPadding),
        //     child: Wrap(
        //       alignment: WrapAlignment.spaceEvenly,
        //       crossAxisAlignment: WrapCrossAlignment.center,
        //       runAlignment: WrapAlignment.spaceEvenly,
        //       runSpacing: kDefaultPadding,
        //       spacing: kDefaultPadding,
        //       children: const [
        //         ImageCardEdit(
        //           isImage: true,
        //         ),
        //         ImageCardEdit(),
        //         ImageCardEdit(),
        //         ImageCardEdit(),
        //         ImageCardEdit(),
        //         ImageCardEdit(),
        //       ],
        //     ),
        //   ),
      ), // )),
    );
  }
}
