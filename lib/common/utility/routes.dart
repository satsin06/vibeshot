import 'package:flutter/material.dart';
import 'package:vibeshot/pages/profile/privacy_policy.dart';
import 'package:vibeshot/pages/profile/terms_and_conditions.dart';
import 'package:vibeshot/pages/splash_screen/splash_screen.dart';
import '../../pages/dashboard/home.dart';

import '../../pages/auth/SignUP/create_account.dart';
import '../../pages/auth/SignUP/create_account_intrested_in.dart';
import '../../pages/auth/SignUP/create_account_my_intrest.dart';
import '../../pages/auth/SignUP/create_account_name.dart';
import '../../pages/auth/SignUP/create_account_upload_images.dart';
import '../../pages/auth/otp_verification.dart';
import '../../pages/auth/signIn/sign_in.dart';
import '../../pages/auth/welcome_screen.dart';
import '../../pages/banners/its_a_match.dart';
import '../../pages/banners/subsciption.dart';
import '../../pages/chat/chats_page.dart';
import '../../pages/dashboard/dashboard.dart';
import '../../pages/dashboard/likes.dart';
import '../../pages/dashboard/matches.dart';
import '../../pages/dashboard/user_profile.dart';
import '../../pages/profile/edit_images.dart';
import '../../pages/profile/edit_profile.dart';
import '../../pages/profile/settings.dart';
import 'route_names.dart';

final Map<String, WidgetBuilder> routes = {
  AppRoutes.welcomeScreen: (context) => const WelcomeScreen(),
  AppRoutes.userProfile: (context) => UserProfilePage(),
  AppRoutes.signInScreen: (context) => const SignInPage(),
  AppRoutes.settings: (context) => SettingsPage(),
  AppRoutes.otpVerification: (context) => OtpVerification(),
  AppRoutes.matches: (context) => const MatchesPage(),
  AppRoutes.dashboard: (context) => const DashBoardPage(),
  AppRoutes.likesPage: (context) => LikesPage(),
  AppRoutes.homepage: (context) => const HomePage(),
  AppRoutes.editProfile: (context) => EditProfilePage(),
  AppRoutes.editImages: (context) => EditImagesPage(),
  AppRoutes.createAccountUpload: (context) => CreateAccountUploadImages(),
  AppRoutes.createAccountScreen: (context) => const CreateAccount(),
  AppRoutes.createAccountName: (context) => CreateAccountName(),
  AppRoutes.createAccountMyIntrest: (context) => CreateAccountMyIntrest(),
  AppRoutes.createAccountIntrestedIn: (context) => CreateAccountIntrestedIn(),
  AppRoutes.chatPage: (context) => ChatPage(),
  AppRoutes.banner_2: (context) => const SubscriptionBanner(),
  AppRoutes.banner_1: (context) => const ItsAMatchBanner(),
  AppRoutes.splashScreen: (context) => const SplashScreen(),
  AppRoutes.privacyPolicy: (context) => const PrivacyPolicyPage(),
  AppRoutes.termsAndCondition: (context) => const TermsAndConditionsPage(),
};
