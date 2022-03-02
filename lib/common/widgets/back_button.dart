import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget {
  MyBackButton({this.onPress});

  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 28,
      icon: const Icon(CupertinoIcons.back),
      onPressed: onPress ?? () => Navigator.pop(context) ,
    );
  }
}
