import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:vibeshot/controller/send_code_again_controller.dart';
import 'package:vibeshot/controller/user_details_controller.dart';
import 'package:vibeshot/controller/user_list_controller.dart';
import 'package:vibeshot/model/model_user.dart';
import 'package:vibeshot/networking/creat_account.dart';
import 'package:vibeshot/networking/get_all_users.dart';
import 'package:vibeshot/networking/profile.dart';
import 'package:vibeshot/pages/auth/SignUP/create_account.dart';

import '../../common/constants/app_constants.dart';
import '../../common/theme/app_text_styles.dart';
import '../../common/theme/colors.dart';
import '../../common/utility/route_names.dart';
import '../../common/utility/size_config.dart';
import '../../common/widgets/app_button.dart';
import '../../common/widgets/back_button.dart';
import 'helper/helper.dart';
import 'package:get/get.dart';

class OtpVerification extends StatelessWidget {
  OtpVerification({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.scaffoldGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: MyBackButton(),
        ),
        body: Center(
          child: OtpForm(
            isSignup: args['isSignup'],
            phoneNumber: args['number'],
            key: ValueKey(args['number']),
          ),
        ),
      ),
    );
  }
}

class OtpForm extends StatefulWidget {
  const OtpForm({
    Key? key,
    required this.isSignup,
    required this.phoneNumber,
  }) : super(key: key);
  final bool isSignup;
  final String phoneNumber;
  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;
  late FocusNode pin5FocusNode;
  late FocusNode pin6FocusNode;

  //User? user = FirebaseAuth.instance.currentUser;

  // Future<QuerySnapshot<Map<String, dynamic>>> ref = FirebaseFirestore.instance
  //     .collection('users')
  //     .where('phoneNumber', isEqualTo: '8130253011')
  //     .get();

  //DocumentReference Uid = FirebaseFirestore.instance.doc('uid');

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future createUser({required String phoneNumber}) async {
    String uid = widget.phoneNumber;
    String? uuid = _userDetailsController.userId;
    String? fcmToken = await firebaseMessaging.getToken();
    if (fcmToken != null) {
      final docUser = FirebaseFirestore.instance.collection('users').doc(uid);

      final data = {
        'phoneNumber': uid,
        'uid': uid,
        'token': fcmToken,
      };
      await docUser.set(data);
    }
  }

  _updateDeviceToken() async {
    String uid = widget.phoneNumber;
    String? fcmToken = await firebaseMessaging.getToken();

    if (fcmToken != null) {
      var tokenRef = firebaseFirestore.collection('users').doc(uid);

      await tokenRef.update({
        'token': fcmToken,
      });
    }
  }

  @override
  void initState() {
    _sendCodeController.startTimer();
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
    pin6FocusNode.dispose();
  }

  String otp = '';

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      otp += value;
      focusNode.requestFocus();
    }
  }

  final SendCodeController _sendCodeController = Get.put(SendCodeController());
  final UserDetailsController _userDetailsController =
      Get.put(UserDetailsController());
  final UserListController _userListController = Get.put(UserListController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationID = "";

  void signOut() async {
    await _auth.signOut();
  }

  void signInWithPhoneAuthCred(AuthCredential phoneAuthCredential) async {
    try {
      final authCred = await _auth.signInWithCredential(phoneAuthCredential);

      if (authCred.user != null) {
        Navigator.restorablePushReplacementNamed(
          context,
          AppRoutes.createAccountName,
        );
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Some Error Occurred. Try Again Later')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Divider(),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                AuthHelper.Enter_Verification_Code,
                style: AppTextStyles.heading.copyWith(fontSize: 32),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(38)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AuthHelper.Sent_To + widget.phoneNumber,
                  style: AppTextStyles.bodyText.copyWith(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () => Navigator.maybePop(context),
                  child: Text(
                    AuthHelper.Chnage,
                    style: AppTextStyles.hyperlinks,
                  ),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(15)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: getProportionateScreenWidth(48),
                  height: getProportionateScreenWidth(50),
                  child: TextFormField(
                    autofocus: true,
                    cursorColor: AppColors.primaryColor,
                    cursorHeight: getProportionateScreenWidth(25),
                    cursorWidth: 1,
                    style: const TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) {
                      nextField(value, pin2FocusNode);
                    },
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(48),
                  height: getProportionateScreenWidth(50),
                  child: TextFormField(
                    focusNode: pin2FocusNode,
                    cursorColor: AppColors.primaryColor,
                    cursorHeight: getProportionateScreenWidth(25),
                    cursorWidth: 1,
                    style: const TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) => nextField(value, pin3FocusNode),
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(48),
                  height: getProportionateScreenWidth(50),
                  child: TextFormField(
                    focusNode: pin3FocusNode,
                    cursorColor: AppColors.primaryColor,
                    cursorHeight: getProportionateScreenWidth(25),
                    cursorWidth: 1,
                    style: const TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) => nextField(value, pin4FocusNode),
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(48),
                  height: getProportionateScreenWidth(50),
                  child: TextFormField(
                    focusNode: pin4FocusNode,
                    cursorColor: AppColors.primaryColor,
                    cursorHeight: getProportionateScreenWidth(25),
                    cursorWidth: 1,
                    style: const TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) => nextField(value, pin5FocusNode),
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(48),
                  height: getProportionateScreenWidth(50),
                  child: TextFormField(
                    focusNode: pin5FocusNode,
                    cursorColor: AppColors.primaryColor,
                    cursorHeight: getProportionateScreenWidth(25),
                    cursorWidth: 1,
                    style: const TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) => nextField(value, pin6FocusNode),
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(48),
                  height: getProportionateScreenWidth(50),
                  child: TextFormField(
                    focusNode: pin6FocusNode,
                    cursorColor: AppColors.primaryColor,
                    cursorHeight: getProportionateScreenWidth(25),
                    cursorWidth: 1,
                    style: const TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) {
                      if (value.length == 1) {
                        otp += value;
                        pin6FocusNode.unfocus();
                        // Then you need to check is the code is correct or not
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Obx(() {
              return (_sendCodeController.sendCodeAgain.value)
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        AuthHelper.Didnt_Get_A_Code,
                        style: AppTextStyles.hyperlinks,
                      ),
                    )
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Did't get a code ? \n" +
                            _sendCodeController.seconds.value.toString() +
                            " seconds to send the opt again",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    );
            }),
            SizedBox(height: getProportionateScreenHeight(40)),
            AppButton(
              buttonText: AuthHelper.Verify,
              onPressed: () async {
                print(otp);
                bool isCorrect = await CreateAccountNetworking.verifyOtp(
                    widget.phoneNumber, otp);
                if (widget.isSignup) {
                  if (isCorrect) {
                    _userDetailsController.getContactNumber(widget.phoneNumber);
                    Navigator.restorablePushReplacementNamed(
                      context,
                      AppRoutes.createAccountName,
                    );

                    //ref.doc(user!.phoneNumber).set({'uid': widget.phoneNumber});

                    // FirebaseFirestore.instance
                    //     .collection('users')
                    //     .where('phoneNumber', isEqualTo: widget.phoneNumber)
                    //     .get();

                    //Uid.set({'Uid': widget.phoneNumber});

                    createUser(phoneNumber: widget.phoneNumber);
                  } else {
                    VxToast.show(
                      context,
                      msg: 'Not Verified',
                      bgColor: AppColors.primaryColor,
                      position: VxToastPosition.center,
                    );
                    Navigator.pop(context);
                  }
                } else {
                  VxToast.show(
                    context,
                    msg: 'Verified',
                    bgColor: AppColors.primaryColor,
                    position: VxToastPosition.center,
                  );
                  bool userListisLoaded = await _userListController.getUsers();
                  if (userListisLoaded) {
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.dashboard);
                    _updateDeviceToken();
                    print(_userDetailsController.userId);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
