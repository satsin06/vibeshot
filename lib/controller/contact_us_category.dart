import 'package:get/get.dart';

class ContactUsCategory extends GetxController {

  var category = 'Category 1'.obs ;

  List<String> categoryList = ['Category 1', 'Category 2', 'Category 3'];

  void selectCategory(String selectedCategory) {
    category.value = selectedCategory ;
  } 
}