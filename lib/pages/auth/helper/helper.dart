// ignore_for_file: constant_identifier_names

import 'package:vibeshot/common/constants/helper.dart';
import 'package:vibeshot/model/intrest_model.dart';

abstract class AuthHelper {
  static const String imageBaseUrl = 'assets/images/auth/';
  static const String welcomeBackgrondImage = imageBaseUrl + 'overlay.png';
  static const String appLogo = imageBaseUrl + 'logo.png';
  static const String ukFlag = imageBaseUrl + 'uk_flag.png';

  //============================Texts==========================================

  static const String createAccount = 'Create Account';
  static const String signIn = 'Sign In';
  static const String tagLine = 'Neque porro quisquam';
  static const String Welcome_To_Vibeshoot = 'Welcome to Vibeshot';
  static const String Whats_Your_PhoneNumber = 'What\'s your phone\n number?';
  static const String Enter_Mobile_Number = 'Enter mobile no. and sign in';
  static const String Dont_Have_A_Account = 'Don\'t have an account?';
  static const String signUp = 'Sign Up';
  static const String Enter_Verification_Code = 'Enter your verification code';
  static const String Sent_To = 'Sent to ';
  static const String Chnage = 'Change';
  static const String Didnt_Get_A_Code = 'Didn\'t get a code?';
  static const String Submit = 'Submit';
  static const String Verify = 'Verify';
  static const String Continue = 'Continue';
  static const String Please_Enter_Phone = 'Please enter your phone number?';
  static const String Verifiaction_Text =
      'We will send a text with a verification code. Message and data rates may apply. ';
  static const String Learn_Number_Changes =
      'Learn what happens when your number changes.';
  static const String Agree_Sign_Up = 'By signing up, you are agreeing to our ';
  static const String Terms_And_Condition = 'Terms and Conditions';
  static const String Complete_Your_Profile = 'Complete your profile.';
  static const String Name = 'Name';
  static const String Age = 'Age';
  static const String Gender = 'Gender';
  static const String About_Me = 'About Me';
  static const String Intrested_In = 'Are interested in?';
  static const String Age_Range = 'Age range?';
  static const String Looking_For = 'Looking for?';
  static const String Upload_Images = 'Please upload images.';
  static const String My_Intrest = 'My interests';
  static const String Intrest_Subtitle =
      'Select interests that you\'d like to share.\n Choose a minimum of 3 interests.';

  //============== DummyData =================

  static const List<String> dummyImages = [
    AppHelper.dummyImageUrl + 'dummy1.png',
    AppHelper.dummyImageUrl + 'dummy2.png',
    AppHelper.dummyImageUrl + 'dummy3.png',
    AppHelper.dummyImageUrl + 'dummy4.png',
  ];

  static const List<String> dummyIntrests = [
    'Music',
    'Chess',
    'Reading',
    'Sketching',
    'Photography',
    'Music',
    'Chess',
    'Reading',
    'Sketching',
    'Photography',
    'Music',
    'Chess',
    'Reading',
    'Sketching',
    'Photography',
  ];

  static List<Intrest> interests = dummyIntrests
      .map(
        (String intrest) => Intrest(
          name: intrest,
        ),
      )
      .toList();
}
