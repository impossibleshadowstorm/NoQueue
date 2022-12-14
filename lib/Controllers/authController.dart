import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:noq/Pages/Login/final_login_screen.dart';
import 'package:noq/Pages/landing_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Pages/Login/Registration/user_registration.dart';

class AuthController extends GetxController {
  // login controllers
  final TextEditingController countryCode = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String verify = "";

  TextEditingController otpController1 = TextEditingController();
  TextEditingController otpController2 = TextEditingController();
  TextEditingController otpController3 = TextEditingController();
  TextEditingController otpController4 = TextEditingController();
  TextEditingController otpController5 = TextEditingController();
  TextEditingController otpController6 = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to login user
  Future<void> loginUser() async {
    var db = await FirebaseFirestore.instance
        .collection("user")
        .doc(phoneController.text)
        .get();

    print(db.data());
    print(phoneController.text);

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          smsCode: otpController1.text +
              otpController2.text +
              otpController3.text +
              otpController4.text +
              otpController5.text +
              otpController6.text,
          verificationId: verify);
      final user = await _auth.signInWithCredential(credential);

      print("After login");

      if (db.data() == null) {
        // final firestore = FirebaseFirestore.instance;
        // firestore.collection('user').doc(phoneController.text).set({
        //   "phone": phoneController.text,
        //   "uid": user.user!.uid,
        // });
        print("Inside Db.data");
        Get.to(() => Registration(uid: user.user!.uid));
      } else {
        var auth = FirebaseAuth.instance;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("userID", auth.currentUser!.uid);
        Get.offAll(() => LandingScreen());
      }
      // if (user != null) {
      //   // Saving User with Shared Preferences
      //   SharedPreferences prefs = await SharedPreferences.getInstance();
      //   await prefs.setString("userID", user.user!.uid);
      //   Get.offAll(() => LandingScreen());
      // } else {
      // }
    } catch (e) {
      print("Wrong OTP!!");
    }
  }

  //Function for logout
  Future<void> logoutUser() async {
    await _auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.offAll(() => const UserAuthentication());
  }
}
