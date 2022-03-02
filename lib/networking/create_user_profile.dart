import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:vibeshot/common/utility/end_points.dart';
import 'package:vibeshot/common/widgets/no_internet_connection.dart';

class CreateUserProfile {
  static Future<String?> createUser(Map body) async {
    try {
      http.Response response = await http.post(
        Uri.parse(
          URLEndPoints.createUser,
        ),
        body: jsonEncode(
          body,
        ),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode < 300) {
        var body = jsonDecode(response.body);
        print(body);
        return body['userId'];
      } else {
        showNoInternetConnectionPopUp();
        print('Error in sending data');
        print(response.body);
        return null;
      }
    } catch (e) {
      showNoInternetConnectionPopUp();
      return null;
    }
  }

  static Future<bool> addPhotos(List<String> imagesUrl, String userId) async {
    Map body = {'userId': userId, 'photos': imagesUrl};

    try {
      http.Response response = await http.post(
        Uri.parse(
          URLEndPoints.sendImages,
        ),
        body: jsonEncode(
          body,
        ),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode < 300) {
        body = jsonDecode(response.body);
        if (body['userId'] == userId) {
          return true;
        } else {
          return false;
        }
      } else {
        showNoInternetConnectionPopUp();
        return false;
      }
    } catch (e) {
      showNoInternetConnectionPopUp();
      return false;
    }
  }
}
