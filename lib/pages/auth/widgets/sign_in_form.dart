import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:vibeshot/common/utility/simple_preferences.dart';
import 'package:vibeshot/controller/sign_in_form_controller.dart';
import 'package:vibeshot/controller/user_details_controller.dart';
import 'package:vibeshot/networking/creat_account.dart';
import 'package:vibeshot/pages/auth/SignUP/create_account.dart';

import '../../../common/constants/app_constants.dart';
import '../../../common/theme/app_text_styles.dart';
import '../../../common/theme/colors.dart';
import '../../../common/utility/keybord.dart';
import '../../../common/utility/route_names.dart';
import '../../../common/utility/size_config.dart';
import '../../../common/widgets/app_button.dart';
import '../SignUP/widgets/verification_text.dart';
import '../helper/helper.dart';
import 'package:get/get.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key, this.signup = true}) : super(key: key);
  final bool signup;
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? phone;
  TextEditingController? _phoneController;
  String imageBaseUrl =
      'https://raw.githubusercontent.com/imtoori/CountryCodePicker/master/flags/in.png';
  final signInFormController = SignInFormController();
  final List<String?> errors = [];
  String countryCode = '+91';
  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController!.dispose();
  }

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  final UserDetailsController _userDetailsController =
      Get.put(UserDetailsController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          (!widget.signup)
              ? Container(
                  width: SizeConfig.screenWidth,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    AuthHelper.Enter_Mobile_Number,
                    style: AppTextStyles.labelText,
                  ),
                )
              : const SizedBox.shrink(),
          const HeightBox(10),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          (widget.signup) ? const VerificationText() : const HeightBox(4),
          AppButton(
            buttonText:
                (widget.signup) ? AuthHelper.Continue : AuthHelper.Submit,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                String phoneNum = countryCode + phone!;

                KeyboardUtil.hideKeyboard(context);

                bool userExist =
                    await _userDetailsController.logInUser(phoneNum);
                if (userExist) {
                  bool isSent = await CreateAccountNetworking.sendOtp(phoneNum);
                  if (isSent) {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.otpVerification,
                      arguments: {
                        'isSignup': false,
                        'number': phoneNum,
                      },
                    );
                    await UserSimplePreferences.setPhoneNum(phoneNum);
                    print(UserSimplePreferences.getPhoneNum());
                    print('pressed');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Problem occured while sending OTP',
                        ),
                      ),
                    );
                  }
                } else {
                  print(phoneNum);
                  bool isSent = await CreateAccountNetworking.sendOtp(phoneNum);
                  if (isSent) {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.otpVerification,
                      arguments: {
                        'isSignup': true,
                        'number': phoneNum,
                      },
                    );
                    await UserSimplePreferences.setPhoneNum(phoneNum);
                    print(UserSimplePreferences.getPhoneNum());
                    ///
                    print('pressed');
                    // ref.add({
                    //   'uid': _phoneController,
                    // });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Problem occured while sending OTP',
                        ),
                      ),
                    );
                  }
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Padding buildEmailFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        controller: _phoneController,
        onSaved: (newValue) => phone = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kPhoneNullError);
          } else if (phoneValidatorRegExp.hasMatch(value)) {
            removeError(error: kInvalidPhoneError);
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kPhoneNullError);
            return kPhoneNullError;
          } else if (!phoneValidatorRegExp.hasMatch(value)) {
            addError(error: kInvalidPhoneError);
            return kInvalidPhoneError;
          }
          setState(() {
            errors.clear();
          });
          return null;
        },
        decoration: InputDecoration(
          hintText: "554967938",
          hintStyle: AppTextStyles.bodyText.copyWith(
            color: AppColors.borderGrey,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: countryPicker(),
          fillColor: (errors.isEmpty)
              ? AppColors.textField
              : AppColors.textFieldError.withOpacity(0.14),
        ),
      ),
    );
  }

  ///=================Make Country Picker Functional by this code in prefix============
  Widget countryPicker() {
    return GestureDetector(
      onTap: () {
        showCountryPicker(
          context: context,
          showPhoneCode: true,
          onSelect: (Country country) {
            setState(() {
              countryCode = '+' + country.phoneCode;
              imageBaseUrl =
                  'https://raw.githubusercontent.com/imtoori/CountryCodePicker/master/flags/${country.countryCode.toLowerCase()}.png';
              print(imageBaseUrl);
            });
          },
        );
      },
      child: SizedBox(
        height: getProportionateScreenHeight(50),
        width: getProportionateScreenWidth(140),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Image(
                image: NetworkImage(imageBaseUrl),
                width: getProportionateScreenWidth(30),
              ),
              const SizedBox(
                width: 12,
              ),
              Center(
                child: Text(
                  countryCode,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(
                width: 9,
              ),
              const VerticalDivider(
                thickness: 1.2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
