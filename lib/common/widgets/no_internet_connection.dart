import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:get/get.dart';

void showNoInternetConnectionPopUp() async {
  bool result = await InternetConnectionChecker().hasConnection;
  if (!result) {
    Get.defaultDialog(
        title: 'ERROR!!!',
        middleText: 'Check your internet connection',
        actions: [
          TextButton(
            onPressed: () => exit(0),
            child: const Text(
              'OK',
            ),
          )
        ]);
    Timer.periodic(
      const Duration(seconds: 5),
      (_) => exit(0),
    );
  }
}
