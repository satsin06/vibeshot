import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibeshot/common/utility/end_points.dart';
import 'package:vibeshot/common/widgets/no_internet_connection.dart';

class ContactUsAPI {
  static Future<bool> sendEmail(Map body) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String userId = sharedPreferences.getString("userid")!;
    String authToken = sharedPreferences.getString("authorization")!;

    String url = URLEndPoints.createLike + '/$userId';
    print(url + "\n" + authToken);
    try {
      http.Response response = await http.post(
        Uri.parse(
          URLEndPoints.contactUs + '/$userId',
        ),
        headers: {
          'Authorization': authToken,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode < 300) {
        return true;
      } else {
        print(response.body);
        return false;
      }
    } catch (e) {
      showNoInternetConnectionPopUp();
      return false;
    }
  }
}
