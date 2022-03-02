import 'package:get/get.dart';
import 'package:vibeshot/controller/intrested_in_controller.dart';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class UserData {
  String uid;
  String name;
  String contact;
  List<String> images;
  String aboutMe;
  int age;
  double latitude;
  double longitude;
  String gender;
  String interestedInGender;
  int minAge;
  int maxAge;
  String lookingFor;
  List<String> interests;
  // bool isAdmin;
  bool isPremium;


  UserData({
    required this.uid,
    required this.name,
    required this.contact,
    required this.images,
    required this.aboutMe,
    required this.age,
    required this.latitude,
    required this.longitude,
    required this.gender,
    required this.interestedInGender,
    required this.minAge,
    required this.maxAge,
    required this.lookingFor,
    required this.interests,
    // required this.isAdmin,
    required this.isPremium,
  });

  static UserData getUserFromJson(Map<String, dynamic> data) {
    return UserData(
      uid: data['userId'],
      name: data['name'],
      contact: data['contact'],
      images: (data['images'] as List).map((e) => e.toString()).toList(),
      aboutMe: data['aboutMe'],
      age: data['age'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      gender: data['gender'],
      interestedInGender: data['interestedInGender'],
      minAge: data["minAge"],
      maxAge: data['maxAge'],
      lookingFor: data['lookingFor'] ?? '',
      interests: (data['interests'] as List).map((e) => e.toString()).toList(),
      // isAdmin: data['isAdmin'],
      isPremium: data['isPremium'],
    );
  }

  @override
  String toString() {
    return name + " -> " + uid;
  }

  Map get asJson => {
        "userId": uid,
        "name": name,
        "contact": contact,
        "images": images,
        "aboutMe": aboutMe,
        "age": age,
        "latitude": latitude,
        "longitude": longitude,
        "gender": gender,
        "interestedInGender": interestedInGender,
        "minAge": minAge,
        "maxAge": maxAge,
        "lookingFor": lookingFor,
        "interests": interests,
        // "isAdmin": isAdmin,
        // "isPremium": isPremium,
      };
}
