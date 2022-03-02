import 'package:get/get.dart';

class IntrestedInController extends GetxController {
  var intrest = 'Male'.obs;

  List<String> intrestCandidate = ['Male', 'Female', 'Other'];

  void selectGender(String newIntrest) {
    intrest.value = newIntrest;
  }

  var lookingFor = 'Friends'.obs;

  Map<String, String> lookingForMap = {'Friends': 'Friends', 'Relationship': 'Relationship', 'Not Sure': 'NotSure'};

  List<String> get lookingForList => ['Friends', 'Relationship', 'Not Sure'];

  void changeLookingFor(String newLookingFor) {
    lookingFor.value = newLookingFor;
  }
}
