import 'package:get/get.dart' ;

class AgeController extends GetxController {

  var age = 31.obs ;
  List<int> ages = [
    for(int i = 18 ; i <= 50 ; i++) i
  ];

  void changeAge(int newAge) {
    age.value = newAge ;
  }
}