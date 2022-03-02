import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibeshot/common/utility/end_points.dart';
import 'package:vibeshot/common/widgets/no_internet_connection.dart';
import 'package:vibeshot/model/model_user.dart';

class ProfileApi {
  static Future<UserData?> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String userId = sharedPreferences.getString("userid")!;
    String authToken = sharedPreferences.getString("authorization")!;
    try {
      http.Response response = await http.get(
        Uri.parse(
          URLEndPoints.getUserById + '/$userId',
        ),
        headers: {'Authorization': authToken},
      );
      if (response.statusCode < 300) {
        var body = jsonDecode(response.body);
        return UserData.getUserFromJson(Map.from(body));
      } else {
        showNoInternetConnectionPopUp();
        print('user data error');
        return null;
      }
    } catch (e) {
      showNoInternetConnectionPopUp();
      return null;
    }
  }

  static Future<UserData?> updateUser(UserData user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String authToken = sharedPreferences.getString("authorization")!;

    print(user.asJson);
    try {
      http.Response response = await http.patch(
        Uri.parse(
          URLEndPoints.getUserById + '/${user.uid}',
        ),
        headers: {
          'Authorization': authToken,
          'Content-Type': 'application/json',
        },
        body: json.encode(user.asJson),
      );

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        print(body);
        return UserData.getUserFromJson(Map.from(body));
      } else {
        showNoInternetConnectionPopUp();
        print(response.body);
        print("error sending data");
        return null;
      }
    } catch (e) {
      showNoInternetConnectionPopUp();
      return null;
    }
  }

  static Future<bool> uploadPhotos(List<String> images) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String userId = sharedPreferences.getString("userid")!;
    String authToken = sharedPreferences.getString("authorization")!;
    print("Sending request at: " + URLEndPoints.sendImages + '/$userId');
    print(authToken);
    try {
      http.Response response = await http.post(
        Uri.parse(
          URLEndPoints.sendImages + '/$userId',
        ),
        headers: {
          'Authorization': authToken,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'images': images}),
      );
      print(response.body);
      if (response.statusCode < 300) {
        return true;
      } else {
        showNoInternetConnectionPopUp();
        print(response.body);
        return false;
      }
    } catch (e) {
      showNoInternetConnectionPopUp();
      return false;
    }
  }

  static Future<bool> deleteUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String userId = sharedPreferences.getString("userid")!;
    String authToken = sharedPreferences.getString("authorization")!;
    try {
      http.Response response = await http.delete(
        Uri.parse(
          URLEndPoints.getUserById + '/$userId',
        ),
        headers: {
          'Authorization': authToken,
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode < 300) {
        showNoInternetConnectionPopUp();
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
