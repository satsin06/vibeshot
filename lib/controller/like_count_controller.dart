import 'package:get/get.dart';
import 'package:vibeshot/database/save_likes.dart';

class LikeCountController extends GetxController {
  RxInt likeCount = 0.obs;

  void getLikeCount() async {
    SaveLikes saveLikes = SaveLikes.instance;

    List<Map> data = await saveLikes.queryAllData();
    if (data.isNotEmpty) {
      likeCount.value = data[0][SaveLikes.likeCount];
      print('like count: ${likeCount.value}');
    }
  }

  @override
  void onInit() {
    getLikeCount();
    super.onInit();
  }
}
