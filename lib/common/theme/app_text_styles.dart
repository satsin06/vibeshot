import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

abstract class AppTextStyles {
  static TextStyle heading = GoogleFonts.poppins(
    color: AppColors.headingText,
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );
  static TextStyle subtitle = GoogleFonts.poppins(
    color: AppColors.headingText,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  static TextStyle bodyText = GoogleFonts.poppins(
    color: AppColors.subtitleText,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  static TextStyle hyperlinks = GoogleFonts.poppins(
    color: AppColors.hyperLink,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.underline,
  );
  static TextStyle buttonText = GoogleFonts.poppins(
    color: AppColors.buttonText,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static TextStyle textfield = GoogleFonts.poppins(
    color: AppColors.headingText,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static TextStyle errorText = GoogleFonts.poppins(
    color: AppColors.errorBorder,
    fontSize: 14,
    fontWeight: FontWeight.w300,
  );

  //====================Welcome Screen=====================================

  static TextStyle logoSubtitle = GoogleFonts.poppins(
    color: AppColors.headingText,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle navLinks = GoogleFonts.poppins(
    color: AppColors.primaryColor,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  //==========================SignIN Screen====================================
  static TextStyle labelText = GoogleFonts.poppins(
    color: AppColors.subtitleText,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  //============================Likes Screen===================================

  static TextStyle likeHeading = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static TextStyle likeCardName = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static TextStyle likeCardAge = GoogleFonts.poppins(
    color: AppColors.subtitleText,
    fontSize: 12,
    fontWeight: FontWeight.w300,
  );
//================================MatchesPages=================================

  static TextStyle profileName = GoogleFonts.poppins(
    color: AppColors.headingText,
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );

  static TextStyle profileAge = GoogleFonts.poppins(
    color: AppColors.headingText,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static TextStyle profileShortDes = GoogleFonts.poppins(
    color: AppColors.headingText,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static TextStyle profileAbout = GoogleFonts.poppins(
    color: const Color(0xff8B9BA8),
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  //=========================Chats=========================================

  static TextStyle chatName = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static TextStyle chatStatus = GoogleFonts.poppins(
    color: const Color(0xffAFADAD),
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  static TextStyle chatRecived = GoogleFonts.poppins(
    color: const Color(0xff000000),
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
  static TextStyle chatTime = GoogleFonts.poppins(
    color: const Color(0xffAFADAD),
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );
  static TextStyle chatSent = GoogleFonts.poppins(
    color: const Color(0xffffffff),
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
  static TextStyle chatSentTime = GoogleFonts.poppins(
    color: const Color(0xffffffff),
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );
  //============================Profile=====================================
  static TextStyle profileHeadingName = GoogleFonts.poppins(
    color: const Color(0xff000000),
    fontSize: 24,
    fontWeight: FontWeight.w400,
  );
  static TextStyle profileIcon = GoogleFonts.poppins(
    color: const Color(0xff7646F6),
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  //=========================Subscribe======================================
  static TextStyle subscribeHeading = GoogleFonts.poppins(
    color: const Color(0xff000000),
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static TextStyle subscribeDes = GoogleFonts.poppins(
    color: const Color(0xff000000),
    fontSize: 14,
    fontWeight: FontWeight.w300,
  );

  static TextStyle subscribeTime = GoogleFonts.poppins(
    color: const Color(0xff000000),
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );
  static TextStyle subscribePrice = GoogleFonts.poppins(
    color: const Color(0xffF6564C),
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );
  static TextStyle subscribeButton = GoogleFonts.poppins(
    color: const Color(0xffFFFFFF),
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  //==================== Edit Image ===============================
  static TextStyle editImageAppBar = GoogleFonts.poppins(
    color: const Color(0xff000000),
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  //====================== Edit Profile ==============================

}
