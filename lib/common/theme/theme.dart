import 'package:flutter/material.dart';

import 'app_text_styles.dart';
import 'base.dart';
import 'colors.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldColor,
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(BaseStyles.borderRadius),
    borderSide: const BorderSide(
      color: AppColors.borderGrey,
      width: 0.5,
    ),
    gapPadding: 10,
  );
  OutlineInputBorder errorInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(BaseStyles.borderRadius),
    borderSide: const BorderSide(
      color: AppColors.errorBorder,
      width: 0.5,
    ),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.symmetric(horizontal: 42, vertical: 15),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    fillColor: AppColors.textField,
    errorBorder: errorInputBorder,
    focusedErrorBorder: errorInputBorder,
    filled: true,
    alignLabelWithHint: true,
    errorStyle: AppTextStyles.errorText,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: AppTextStyles.bodyText,
    bodyText2: AppTextStyles.subtitle,
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Color.fromRGBO(240, 237, 249, 0.98),
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.black),
    actionsIconTheme: IconThemeData(color: Colors.black, size: 24),
  );
}
