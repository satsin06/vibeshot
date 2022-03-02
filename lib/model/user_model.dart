import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  String name;
  String age;
  List<String> profileImage;
  List<String> featuredImage;
  String distance;
  String about;
  String shortDescription;
  UserModel({
    required this.name,
    required this.age,
    required this.profileImage,
    required this.featuredImage,
    required this.distance,
    required this.about,
    required this.shortDescription,
  });

  UserModel copyWith({
    String? name,
    String? age,
    List<String>? profileImage,
    List<String>? featuredImage,
    String? distance,
    String? about,
    String? shortDescription,
  }) {
    return UserModel(
      name: name ?? this.name,
      age: age ?? this.age,
      profileImage: profileImage ?? this.profileImage,
      featuredImage: featuredImage ?? this.featuredImage,
      distance: distance ?? this.distance,
      about: about ?? this.about,
      shortDescription: shortDescription ?? this.shortDescription,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'profileImage': profileImage,
      'featuredImage': featuredImage,
      'distance': distance,
      'about': about,
      'shortDescription': shortDescription,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      age: map['age'],
      profileImage: List<String>.from(map['profileImage']),
      featuredImage: List<String>.from(map['featuredImage']),
      distance: map['distance'],
      about: map['about'],
      shortDescription: map['shortDescription'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(name: $name, age: $age, profileImage: $profileImage, featuredImage: $featuredImage, distance: $distance, about: $about, shortDescription: $shortDescription)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.age == age &&
        listEquals(other.profileImage, profileImage) &&
        listEquals(other.featuredImage, featuredImage) &&
        other.distance == distance &&
        other.about == about &&
        other.shortDescription == shortDescription;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        age.hashCode ^
        profileImage.hashCode ^
        featuredImage.hashCode ^
        distance.hashCode ^
        about.hashCode ^
        shortDescription.hashCode;
  }
}
