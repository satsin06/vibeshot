import 'package:get/get.dart';

class SignInFormController extends GetxController {
  String countryCode = '+91';
  String? phone;
  final String _phoneNum = '';
  String get phoneNum => _phoneNum;

  void getPhoneNum() {
    String _phoneNum = countryCode + phone!;
    update();
    print(_phoneNum);
  }
}
