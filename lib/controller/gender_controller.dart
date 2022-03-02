import 'package:get/get.dart';

class GenderController extends GetxController {
  var male = true.obs;
  var femail = false.obs;
  var other = false.obs;
  String currentGender = 'Male';

  void changeGender(int index) {
    switch (index) {
      case 0:
        male.value = true;
        femail.value = false;
        other.value = false;
        currentGender = 'Male';
        break;
      case 1:
        male.value = false;
        femail.value = true;
        other.value = false;
        currentGender = 'Female';
        break;
      case 2:
        male.value = false;
        femail.value = false;
        other.value = true;
        currentGender = 'Other';
        break;
      default:
        print('spomething went wrong');
    }
  }
}
