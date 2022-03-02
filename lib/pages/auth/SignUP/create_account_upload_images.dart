import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:vibeshot/common/utility/simple_preferences.dart';
import 'package:vibeshot/controller/add_image_controller.dart';
import 'package:vibeshot/controller/user_details_controller.dart';
import 'package:vibeshot/controller/user_list_controller.dart';
import 'package:vibeshot/networking/profile.dart';

import '../../../common/theme/app_text_styles.dart';
import '../../../common/theme/colors.dart';
import '../../../common/utility/route_names.dart';
import '../../../common/utility/size_config.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/back_button.dart';
import '../helper/helper.dart';
import 'package:get/get.dart';

class CreateAccountUploadImages extends StatelessWidget {
  CreateAccountUploadImages({Key? key}) : super(key: key);

  final AddImageController _addImageController = Get.put(AddImageController());
  final UserDetailsController _userDetailsController =
      Get.put(UserDetailsController());

  final UserListController _userListController = Get.put(UserListController());
  Future updateUser() async {
    String uid = UserSimplePreferences.getPhoneNum().toString();
    final updateUser = FirebaseFirestore.instance.collection('users').doc(uid);

    final data = {
      'image': _addImageController.imagesUrl,
    };

    await updateUser.update(data);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.scaffoldGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 1.5,
          leading: MyBackButton(),
        ),
        body: Obx(() {
          return ModalProgressHUD(
            inAsyncCall: _addImageController.isUploading.value,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeightBox(getProportionateScreenHeight(20)),
                  Text(
                    AuthHelper.Upload_Images,
                    style: AppTextStyles.heading,
                  ),
                  HeightBox(getProportionateScreenHeight(30)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.60,
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: Obx(() {
                      return GridView.builder(
                        itemCount: _addImageController.images.value.length + 1,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemBuilder: (BuildContext context, int index) {
                          return (index ==
                                  _addImageController.images.value.length)
                              ? (_addImageController.images.length < 6)
                                  ? AddMore(_addImageController.pickImage)
                                  : Container()
                              : AddImageCard(
                                  image:
                                      _addImageController.images.value[index],
                                  onPressDelete: () {
                                    _addImageController
                                        .deleteImageAtIndex(index);
                                  },
                                );
                        },
                      );
                    }),
                  ),
                  const Spacer(),
                  AppButton(
                      buttonText: AuthHelper.Continue,
                      onPressed: () async {
                        if (_addImageController.images.isNotEmpty) {
                          bool isDone = await _addImageController
                              .uploadImages(_userDetailsController.userId!, updateUser());
                              updateUser();
                          if (isDone) {
                            bool userExist = await _userDetailsController
                                .logInUser(_userDetailsController.contact!);
                                updateUser();
                            bool userListisLoaded =
                                await _userListController.getUsers();
                            if (userListisLoaded) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRoutes.dashboard,
                                (Route<dynamic> route) => false,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Error Loading User Data',
                                  ),
                                ),
                              );
                              Navigator.popUntil(
                                context,
                                ModalRoute.withName(
                                  AppRoutes.welcomeScreen,
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Problem occured while uploading images',
                                ),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Select atleast one image',
                              ),
                            ),
                          );
                        }
                      }),
                  HeightBox(getProportionateScreenHeight(40)),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(100),
      height: getProportionateScreenHeight(109),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        image: DecorationImage(
          image: AssetImage(AuthHelper.dummyImages[index]),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class AddMore extends StatelessWidget {
  AddMore(this.ontap);

  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: const EdgeInsets.all(2.5),
        width: getProportionateScreenWidth(100),
        height: getProportionateScreenHeight(109),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            color: AppColors.primaryColor),
        child: const Center(
          child: Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
    );
  }
}

class AddImageCard extends StatelessWidget {
  const AddImageCard(
      {Key? key, required this.image, required this.onPressDelete})
      : super(key: key);
  final File image;
  final VoidCallback onPressDelete;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(2.5),
          width: getProportionateScreenWidth(100),
          height: getProportionateScreenHeight(109),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            image: DecorationImage(
              image: FileImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 2,
          child: SizedBox(
            height: 35,
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: onPressDelete,
              child: const Icon(Icons.clear),
            ),
          ),
        )
      ],
    );
  }
}
