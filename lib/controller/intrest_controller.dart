import 'package:get/get.dart';
import 'package:vibeshot/model/intrest_model.dart';

class IntrestController extends GetxController {
  var intrests = <Intrest>[].obs;
  var forEdittingProfile = false;

  void intrestClicked(Intrest newIntrest) {
    if (intrests.length >= 5) {
      if (intrests.contains(newIntrest)) {
        intrests.remove(newIntrest);
        newIntrest.isSelected.value = !newIntrest.isSelected.value;
      } else {
        print('Not in list');
      }
      print(intrests.map((element) => element.name));
      return;
    } else {
      if (intrests.contains(newIntrest)) {
        intrests.remove(newIntrest);
      } else {
        intrests.value.add(newIntrest);
      }
      newIntrest.isSelected.value = !newIntrest.isSelected.value;
      notifyChildrens();
      print('in the section to add new');
    }
  }
}
