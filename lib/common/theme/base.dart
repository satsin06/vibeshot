import 'package:flutter/material.dart';

abstract class BaseStyles {
  static double get borderRadius => 10.0;

  static double get borderWidth => 2.0;

  static double get listFieldHorizontal => 20.0;

  static double get listFieldVertical => 8.0;

  static double get animationOffset => 2.0;

  static EdgeInsets get listPadding {
    return EdgeInsets.symmetric(
        horizontal: listFieldHorizontal, vertical: listFieldVertical);
  }
}
