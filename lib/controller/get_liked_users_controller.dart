import 'package:get/get.dart';
import 'package:vibeshot/database/save_likes.dart';
import 'package:vibeshot/model/model_user.dart';
import 'package:vibeshot/networking/likes_api.dart';

class LikedUserController extends GetxController {
  var isloading = false.obs;
  var likedUserList = <UserData>[].obs;

  Future getLikedUsers() async {
    isloading.value = true;
    List<UserData>? likedList = await LikeApi.getAllLikes();
    if (likedList != null) {
      likedUserList.value.clear();
      likedUserList.value = likedList;
    }
    isloading.value = false;
    SaveLikes saveLikes = SaveLikes.instance;
    saveLikes.addLikeCount(likedUserList.length);
    notifyChildrens();
  }

  @override
  void onInit() {
    getLikedUsers();
    super.onInit();
  }
}
