import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vibeshot/common/utility/end_points.dart';
import 'package:vibeshot/common/widgets/no_internet_connection.dart';

class UserLogin {
  static Future<Map?> logIn(String phoneNumber,
  //String deviceToken
  ) async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var request = http.Request(
        'GET',
        Uri.parse(
          URLEndPoints.logIn,
        ),
      );
      request.body = jsonEncode({"contact": phoneNumber, 
      //"deviceToken": deviceToken
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode < 300) {
        showNoInternetConnectionPopUp();
        return response.headers;
      } else {
        return null;
      }
    } catch (e) {
      showNoInternetConnectionPopUp();
      return null;
    }
  }
}
