import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibeshot/common/utility/end_points.dart';
import 'package:vibeshot/common/widgets/no_internet_connection.dart';
import 'package:vibeshot/controller/user_details_controller.dart';
import 'package:vibeshot/controller/user_list_controller.dart';
import 'package:vibeshot/model/model_user.dart';
import 'package:get/get.dart';

class GetAllUsers {
  static Future<List<UserData>?> getAllUsers(int number) async {
    UserDetailsController _userDetailController =
        Get.put(UserDetailsController());
    UserListController _userListController = Get.put(UserListController());
    SharedPreferences pref = await SharedPreferences.getInstance();

    String authToken = pref.getString('authorization') ?? '';

    if (authToken.isNotEmpty) {
      var headers = {
        'Authorization': authToken,
        'Content-Type': 'application/json'
      };
      try {
        var request = http.Request(
          'GET',
          Uri.parse(
            URLEndPoints.getAllUser + '?page=$number&limit=25',
          ),
        );
        request.body = jsonEncode({
          "minAge": _userDetailController.minAge,
          "maxAge": _userDetailController.maxAge,
          "interestedInGender": _userDetailController.intrestedgender,
          "lookingFor": _userDetailController.lookingFor,
          "userId": _userDetailController.userId
        });
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          var body = jsonDecode(await response.stream.bytesToString());
          List<UserData> userList = [];
          _userListController.changePageNumber(body['page']);
          for (var item in body['userResponse']) {
            userList.add(UserData.getUserFromJson(Map.from(item)));
          }
          return userList;
        } else {
          showNoInternetConnectionPopUp();
          print("Got an error");
          return null;
        }
      } catch (e) {
        showNoInternetConnectionPopUp();
        return null;
      }
    }
  }

  static Future<UserData?> createLike(String likedUser) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String userId = sharedPreferences.getString("userid")!;
    String authToken = sharedPreferences.getString("authorization")!;

    String url = URLEndPoints.createLike + '/$userId?likesTo=$likedUser';
    print(url + "\n" + authToken);

    try {
      http.Response response = await http.post(
        Uri.parse(
          URLEndPoints.createLike + '/$userId?likesTo=$likedUser',
        ),
        headers: {'Authorization': authToken},
      );
      if (response.statusCode < 300) {
        String bodyString = response.body;
        if (bodyString.trim().isNotEmpty) {
          print('Match');
          var body = jsonDecode(response.body);
          print(body);
          return UserData.getUserFromJson(Map.from(body));
        } else {
          print("Liked");
          return null;
        }
      } else {
        print(response.body);
        print('user data error');
        return null;
      }
    } catch (e) {
      showNoInternetConnectionPopUp();
      return null;
    }
  }
}
