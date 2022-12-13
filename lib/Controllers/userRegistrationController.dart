import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noq/Controllers/authController.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Pages/landing_screen.dart';

AuthController authController = Get.find();

class UserRegistrationController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    addressController.text = "";
    super.onInit();
  }

  // Textfirelds Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = authController.phoneController;
  final TextEditingController addressController = TextEditingController();

  Future<void> setUserData() async {
    // var db = await FirebaseFirestore.instance
    //     .collection("user")
    //     .doc(phoneController.text)
    //     .get();
    var auth = FirebaseAuth.instance;

    final firestore = FirebaseFirestore.instance;
    firestore.collection('user').doc(phoneController.text).set({
      "uid": auth.currentUser?.uid,
      "name": firstNameController.text + lastNameController.text,
      "phone": phoneController.text,
      "email": emailController.text,
      "address": addressController.text,
    });

    // Saving User with Shared Preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userID", auth.currentUser!.uid);
    Get.offAll(() => LandingScreen());
  }
}
