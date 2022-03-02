import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibeshot/common/utility/end_points.dart';
import 'package:vibeshot/common/widgets/no_internet_connection.dart';
import 'package:vibeshot/model/model_user.dart';

class LikeApi {
  static Future<List<UserData>?> getAllLikes() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String userId = sharedPreferences.getString("userid")!;
    String authToken = sharedPreferences.getString("authorization")!;
    try {
      http.Response response = await http.get(
        Uri.parse(
          URLEndPoints.createLike + '/$userId',
        ),
        headers: {'Authorization': authToken},
      );
      if (response.statusCode < 300) {
        var body = jsonDecode(response.body);
        List<UserData> likedList = [];
        for (var item in body) {
          likedList.add(
            UserData.getUserFromJson(
              Map.from(
                item,
              ),
            ),
          );
        }
        return likedList;
      } else {
        showNoInternetConnectionPopUp();
        print(response.body);
        print('user data error');
        return null;
      }
    } catch (e) {
      showNoInternetConnectionPopUp();
      return null;
    }
  }

  static Future<bool> deleteLike(String likedUser) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String userId = sharedPreferences.getString("userid")!;
    String authToken = sharedPreferences.getString("authorization")!;

    String url = URLEndPoints.createLike + '/$userId?likesTo=$likedUser';
    print(url + "\n" + authToken);
    try {
      http.Response response = await http.delete(
        Uri.parse(
          URLEndPoints.createLike + '/$userId?likesTo=$likedUser',
        ),
        headers: {'Authorization': authToken},
      );
      if (response.statusCode < 300) {
        var body = jsonDecode(response.body);
        return body['operationResult'] == 'SUCCESS';
      } else {
        showNoInternetConnectionPopUp();
        print('not deleted');
        print(response.body);
        return false;
      }
    } catch (e) {
      showNoInternetConnectionPopUp();
      return false;
    }
  }
}
