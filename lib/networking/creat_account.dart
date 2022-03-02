import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vibeshot/common/utility/end_points.dart';
import 'package:vibeshot/common/widgets/no_internet_connection.dart';

class CreateAccountNetworking {
  static Future<bool> sendOtp(String phonNumber) async {
    Map<String, String> body = {
      'contact': phonNumber,
    };
    try {
      http.Response response = await http.post(
        Uri.parse(
          URLEndPoints.sendOtp,
        ),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode < 300) {
        var body = jsonDecode(response.body);
        if (body['operationResult'] == 'SUCCESS') {
          return true;
        } else {
          return false;
        }
      } else {
        showNoInternetConnectionPopUp();
        print('API not working');
        print(response.body);
        return false;
      }
    } catch (e) {
      showNoInternetConnectionPopUp();
      return false;
    }
  }

  static Future<bool> verifyOtp(String phoneNumber, String OTP) async {
    Map<String, String> body = {
      'contact': phoneNumber,
      'token': OTP,
    };
    try {
      http.Response response = await http.post(
        Uri.parse(
          URLEndPoints.verifyOTP,
        ),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode < 300) {
        var body = jsonDecode(response.body);
        print(body);
        if (body['operationResult'] == 'SUCCESS') {
          return true;
        } else {
          return false;
        }
      } else {
        showNoInternetConnectionPopUp();
        print('API not working');
        print(response.body);
        return false;
      }
    } catch (e) {
      showNoInternetConnectionPopUp();
      return false;
    }
  }
}
