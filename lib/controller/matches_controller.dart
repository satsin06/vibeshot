import 'package:get/get.dart';
import 'package:vibeshot/model/model_user.dart';
import 'package:vibeshot/networking/likes_api.dart';
import 'package:vibeshot/networking/matches_api.dart';

class MatchesController extends GetxController {
  var isloading = false.obs;
  var matches = <UserData>[].obs;

  Future getMatchUsers() async {
    isloading.value = true;
    List<UserData>? matchList = await MatchesApi.getMatches();
    if (matchList != null) {
      matches.value = matchList;
    }
    isloading.value = false;
  }

  void filterUsers(String name) async {
    if (name.isEmpty) {
      getMatchUsers();
      return;
    }
    matches.value = matches
        .where(
          (UserData user) => user.name.toLowerCase().contains(
                name.toLowerCase(),
              ),
        )
        .toList();
  }

  @override
  void onInit() {
    getMatchUsers();
    super.onInit();
  }
}
