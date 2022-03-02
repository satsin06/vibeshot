import 'dart:async';

import 'package:get/get.dart';

class SendCodeController extends GetxController {
  var sendCodeAgain = false.obs;
  var seconds = 90.obs;
  Timer? _timer;

  void startTimer() {
    seconds = 90.obs;
    sendCodeAgain = false.obs;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => decreaseTime(),
    );
  }

  void decreaseTime() {
    if (seconds.value > 0) {
      seconds.value--;
    } else {
      sendCodeAgain.value = true;
      _timer!.cancel();
    }
  }
}
