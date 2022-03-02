import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences? _preferences;

  static const _keyPhoneNum = 'phoneNum';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setPhoneNum(String phoneNum) async =>
      await _preferences?.setString(_keyPhoneNum, phoneNum);

  static String? getPhoneNum() => _preferences?.getString(_keyPhoneNum);

  static Future<bool>? deletePhoneNum() => _preferences?.remove(_keyPhoneNum);
}
