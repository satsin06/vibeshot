import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:vibeshot/controller/contact_us_category.dart';
import 'package:vibeshot/networking/contact_us.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/helper.dart';
import '../../common/theme/app_text_styles.dart';
import '../../common/theme/colors.dart';
import '../../common/utility/size_config.dart';
import '../../common/widgets/app_button.dart';
import '../../common/widgets/app_text_field.dart';
import '../../common/widgets/back_button.dart';
import '../auth/helper/helper.dart';
import 'package:get/get.dart';

class ContactUS extends StatelessWidget {
  ContactUS({Key? key}) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final ContactUsCategory _contactUsCategory = Get.put(ContactUsCategory());
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.scaffoldGradient,
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: MyBackButton(),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Contact Us',
              style: AppTextStyles.heading.copyWith(
                fontSize: 18,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppTextField(
                  controller: nameController,
                  hintText: AuthHelper.Name,
                  lable: AuthHelper.Name,
                ),
                AppTextField(
                  controller: emailController,
                  lable: 'Email',
                  hintText: 'helenenzie@yahoo.com',
                ),
                AppTextField(
                  controller: subjectController,
                  hintText: 'Subject',
                  lable: 'Subject',
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'Looking for?',
                        textAlign: TextAlign.left,
                        style: AppTextStyles.textfield.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.subtitleText,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(() {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.shade400, width: 1),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            borderRadius: BorderRadius.circular(10),
                            isExpanded: true,
                            value: _contactUsCategory.category.value,
                            onChanged: (String? value) {
                              _contactUsCategory.selectCategory(value!);
                            },
                            items: _contactUsCategory.categoryList
                                .map(
                                  (String element) => DropdownMenuItem(
                                    value: element,
                                    child: Text(
                                      element,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                MessageTextField(messageController),
                AppButton(
                  buttonText: 'Send',
                  onPressed: () async {
                    if (nameController.text.isNotEmpty &&
                        emailController.text.isNotEmpty &&
                        subjectController.text.isNotEmpty &&
                        messageController.text.isNotEmpty) {
                      Map body = {
                        'title': subjectController.text,
                        'category': _contactUsCategory.category.value,
                        'body': messageController.text,
                        'userEmail': emailController.text,
                        'Name': nameController.text,
                      };
                      bool isSent = await ContactUsAPI.sendEmail(body);
                      if (isSent) {
                        print('Sent');
                        Navigator.pop(context);
                      } else {
                        print('Not sent');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Data Not Sent',
                            ),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Fill all the text Fileds',
                          ),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MessageTextField extends StatelessWidget {
  MessageTextField(this.controller);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Text(
              'Message',
              style: AppTextStyles.textfield.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.subtitleText,
              ),
            ),
          ),
          const HeightBox(6),
          TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: 15,
            minLines: 6,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                hintText: AppHelper.loreumIpsum,
                hintStyle: AppTextStyles.bodyText.copyWith(
                  color: AppColors.borderGrey,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                fillColor: AppColors.textField),
          ),
        ],
      ),
    );
  }
}
