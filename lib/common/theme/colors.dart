import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color scaffoldColor = Color.fromRGBO(240, 237, 249, 0.98);
  static const Color primaryColor = Color(0xff7646F6);
  static const Color headingText = Color(0xff000000);
  static const Color subtitleText = Color(0xff7B7B7B);
  static const Color buttonText = Color(0xffFFFFFF);
  static const Color textField = Color(0xffFFFFFF);
  static const Color textFieldError = Color.fromRGBO(246, 86, 76, 14);
  static const Color errorBorder = Color(0xffF6564C);
  static const Color hyperLink = Color(0xff099CFE);

  static const Color borderGrey = Color(0xffAFADAD);
  static const Color cardGrey = Color(0xffD9D6D6);

  static const Color innerShadow = Color.fromRGBO(246, 86, 76, 0.22);
  static const Color outerShadow = Color.fromRGBO(0, 0, 0, 0.16);

  static const LinearGradient scaffoldGradient = LinearGradient(
    colors: [
      Color.fromRGBO(240, 237, 249, 0.98),
      Color.fromRGBO(255, 255, 255, 1),
    ],
  );
}
