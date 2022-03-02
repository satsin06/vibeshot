import 'package:get/get.dart';

class AgeRangeController extends GetxController {

  var lowerRange = 27.0.obs ;
  var upperRange = 40.0.obs ;
  var range = <double>[27.0, 40.0].obs ;

  @override
  void onInit() {
    range = [lowerRange.value, upperRange.value].obs;
    super.onInit();
  }

  void updateRange(double lower, double upper) {
    lowerRange.value = lower ;
    upperRange.value = upper ;
    range = [lower, upper].obs;
  }
}