import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../utility/size_config.dart';

const double kDefaultPadding = 20.0;
const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp phoneValidatorRegExp = RegExp(r"^(?:[+0]9)?[0-9]{10}$");
const String kPhoneNullError = "Please Enter your phone";
const String kInvalidPhoneError = "Please Enter Valid Phone";

const String kPassNullError = "Please Enter your password";
const String kNullError = "Please Enter Value";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(
    vertical: getProportionateScreenWidth(6),
  ),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(10)),
    borderSide: const BorderSide(
      color: AppColors.borderGrey,
    ),
  );
}
