import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibeshot/common/utility/route_names.dart';
import 'package:vibeshot/common/utility/simple_preferences.dart';
import 'package:vibeshot/controller/add_image_controller.dart';
import 'package:vibeshot/controller/age_controller.dart';
import 'package:vibeshot/controller/age_range_controller.dart';
import 'package:vibeshot/controller/intrest_controller.dart';
import 'package:vibeshot/controller/intrested_in_controller.dart';
import 'package:vibeshot/database/saved_user_data.dart';
import 'package:vibeshot/model/intrest_model.dart';
import 'package:vibeshot/model/model_user.dart';
import 'package:vibeshot/networking/create_user_profile.dart';
import 'package:vibeshot/networking/profile.dart';
import 'package:vibeshot/networking/user_login.dart';
class UserDetailsController extends GetxController {
  String? userId;
  String? name;
  int? age;
  String? gender;
  String? aboutMe;
  String? intrestedgender;
  int? minAge;
  int? maxAge;
  String? lookingFor;
  RxList<Intrest>? interests;
  String? contact;
  SharedPreferences? pref;
  Rx<UserData>? user;
  final AgeController _ageController = Get.put(
    AgeController(),
  );
  final IntrestController _intrestController = Get.put(IntrestController());
  final AgeRangeController _ageRangeController = Get.put(AgeRangeController());
  final IntrestedInController _intrestedInController =
      Get.put(IntrestedInController());
  final AddImageController _addImageController = Get.put(AddImageController());
  String? deviceToken;

  @override
  void onInit() async {
    pref = await SharedPreferences.getInstance();
    super.onInit();
  }

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  _updateDeviceToken() async {
    String uid = UserSimplePreferences.getPhoneNum().toString();
    String? fcmToken = await firebaseMessaging.getToken();

    if (fcmToken != null) {
      var tokenRef = firebaseFirestore.collection('users').doc(uid);

      await tokenRef.set({
        'token': fcmToken,
      });
    }
  }

  void getDataFromCreateAccountName(
      String name, int age, String gender, String aboutMe) {
    this.name = name;
    this.age = age;
    this.gender = gender;
    this.aboutMe = aboutMe;
  }

  void getDataFromCreateAccountIntrestedIn({
    required String intrestedIn,
    required int minAge,
    required int maxAge,
    required String lookingFor,
  }) {
    this.intrestedgender = intrestedIn;
    this.minAge = minAge;
    this.maxAge = maxAge;
    this.lookingFor = lookingFor;

    print(
        '${this.intrestedgender}\n${this.minAge}\n${this.maxAge}\n${this.lookingFor}');
  }

  void getDatFromCreateAccountMyIntrest(List<Intrest> intrest) {
    if (this.interests != null) {
      this.interests!.value = intrest;
    } else {
      this.interests = <Intrest>[].obs;
      this.interests!.value = intrest;
    }
  }

  void getContactNumber(String number) {
    this.contact = number;
  }

  Map getUserDetailsAsJSON() {
    return {
      'name': name!,
      'age': age!,
      'gender': gender!,
      'aboutMe': aboutMe!,
      'interestedInGender': intrestedgender!,
      'minAge': minAge!,
      'maxAge': maxAge!,
      'lookingFor': lookingFor!,
      'interests':
          interests!.value.map((Intrest intrest) => intrest.name).toList(),
      'contact': contact!,
      'token': deviceToken
    };
  }

  Future sendData() async {
    Map body = getUserDetailsAsJSON();
    print(body);
    String? data = await CreateUserProfile.createUser(body);
    if (data != null) {
      this.userId = data;
    }
  }

  Future uploadics(List<String> urls) async {
    await CreateUserProfile.addPhotos(urls, userId!);
  }

  Future fillDataInDataBase({UserData? user}) async {
    user ??= await ProfileApi.getUserData();
    this.user = user!.obs;
    _ageController.changeAge(user.age);
    print('Entered');
    if (user != null) {
      userId = user.uid;
      _addImageController.addImages(user.images);
      getDataFromCreateAccountName(
        user.name,
        user.age,
        user.gender,
        user.aboutMe,
      );
      getDataFromCreateAccountIntrestedIn(
        intrestedIn: user.interestedInGender,
        minAge: user.minAge,
        maxAge: user.maxAge,
        lookingFor: user.lookingFor,
      );
      List<Intrest> intrestList = user.interests
          .map((String element) => Intrest(name: element))
          .toList();
      intrestList.forEach((Intrest intrest) => intrest.isSelected.value = true);
      _intrestController.intrests.value.clear();
      _intrestController.intrests.value = intrestList;
      getDatFromCreateAccountMyIntrest(intrestList);
      getContactNumber(user.contact);

      _ageRangeController.updateRange(
          user.minAge.toDouble(), user.maxAge.toDouble());
      _intrestedInController.changeLookingFor(user.lookingFor);
      _intrestedInController.selectGender(user.interestedInGender);

      // Map<String, dynamic> userData = {
      //   SavedUserData.userId: user.userId,
      //   SavedUserData.name: user.name,
      //   SavedUserData.age: user.age,
      //   SavedUserData.gender: user.gender,
      //   SavedUserData.aboutMe: user.aboutMe,
      //   SavedUserData.interestedInGender: user.interestedInGender,
      //   SavedUserData.minAge: user.minAge,
      //   SavedUserData.maxAge: user.maxAge,
      //   SavedUserData.lookingFor: user.lookingFor,
      //   SavedUserData.contact: user.contact
      // };

      // print("data saved");

      // SavedUserData savedUserData = SavedUserData.instance;
      // int id = await savedUserData.addUserDetails(userData);
      // if (id >= 0) {
      //   print('Saved');
      // } else {
      //   print(id);
      // }
    } else {
      print("user is null");
    }
  }

  Future<bool> logInUser(String phoneNumber) async {
    pref = await SharedPreferences.getInstance();
    print(phoneNumber);
    //String deviceToken = _updateDeviceToken();
    Map? data = await UserLogin.logIn(phoneNumber);
    if (data != null) {
      pref!.setString('authorization', data['authorization']);
      pref!.setString('userid', data['userid']);
      print(data);
      await fillDataInDataBase();
      return true;
    } else {
      return false;
    }
  }

  Future updateProfile() async {
    UserData? user = await ProfileApi.updateUser(this.user!.value);
    if (user != null) {
      this.user!.value = user;
      fillDataInDataBase(user: user);
    } else {
      print('disnt got user data back');
    }
  }
}
