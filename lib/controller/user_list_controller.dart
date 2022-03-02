import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibeshot/model/model_user.dart';
import 'package:vibeshot/networking/get_all_users.dart';
import 'package:vibeshot/pages/dashboard/components/draggable_card_widget.dart';

class UserListController extends GetxController {
  List<UserData> userList = [];
  var draggableUserCard = <DraggableCardWidget>[].obs;
  int pageNumber = -1;
  var showMoreUsers = true.obs;

  @override
  void onInit() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? pageNo = sharedPreferences.getInt('pageNumber');
    if (pageNo != null) {
      print('Page NUmber Updated -> $pageNo');
      changePageNumber(pageNo);
    } else {
      sharedPreferences.setInt('pageNumber', -1);
      print('pageNumber set');
    }
    super.onInit();
  }

  Future<void> changePageNumber(int number) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('pageNumber', number);
    pageNumber = number;
  }

  Future<void> changeShowMoreUsers(bool value) async {
    showMoreUsers.value = value;
    await noteTime();
    notifyChildrens();
  }

  Future<void> noteTime() async {
    DateTime newTime = DateTime.now().add(const Duration(hours: 25));
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('time', newTime.toString());
    print('next time -> $newTime');
  }

  Future<bool> validateTime() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? time = sharedPreferences.getString('time');
    if (time != null) {
      DateTime current = DateTime.now();
      DateTime expected = DateTime.parse(time);
      print(' -> > > > > > > > > > $expected');
      if (current.isAfter(expected)) {
        showMoreUsers.value = true;
        notifyChildrens();
        return true;
      } else {
        showMoreUsers.value = false;
        notifyChildrens();
        return false;
      }
    } else {
      return true;
    }
  }

  Future<bool> getUsers() async {
    
    bool showData = await validateTime();
    print(showData);

    if (showData) {
      print('page number: ${pageNumber + 1}');
      List<UserData>? getUserList =
          await GetAllUsers.getAllUsers(pageNumber + 1);
      print('user list: $getUserList');
      if (getUserList != null) {
        if (getUserList.isEmpty) {
          loadUserFromBeginning();
        } else {
          userList.clear();
          userList.addAll(getUserList);
          draggableUserCard.value = List.generate(
            userList.length,
            (int index) {
              UserData user = userList[index];
              return DraggableCardWidget(
                name: user.name,
                age: user.age,
                miles: 1.4,
                about: user.aboutMe,
                intrests: user.interests,
                images: user.images,
              );
            },
          );
        }
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  void loadUserFromBeginning() async {
    print('Page Number reset');
    await changePageNumber(-1);
    print('page number: ${pageNumber + 1}');
    List<UserData>? getUserList = await GetAllUsers.getAllUsers(pageNumber + 1);
    print('user list: $getUserList');
    if (getUserList != null) {
      userList.clear();
      userList.addAll(getUserList);
      draggableUserCard.value = List.generate(
        userList.length,
        (int index) {
          UserData user = userList[index];
          return DraggableCardWidget(
            name: user.name,
            age: user.age,
            miles: 1.4,
            about: user.aboutMe,
            intrests: user.interests,
            images: user.images,
          );
        },
      );
    }
  }
}
