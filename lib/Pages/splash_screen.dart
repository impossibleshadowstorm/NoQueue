import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noq/Pages/Scanner/scanner_screen.dart';
import 'package:noq/Pages/cart_screen.dart';
import 'package:noq/Pages/Login/final_login_screen.dart';
import 'package:noq/Pages/landing_screen.dart';
import 'package:noq/Pages/Login/OTP/otp_screen.dart';
import 'package:noq/Pages/ProductDescription/product_description_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login/Registration/user_registration.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var auth = FirebaseAuth.instance;
  var isLogin = false;

  checkIfLogin() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        print("hello");
        setState(() {
          isLogin = true;
        });
      }
    });
  }

  _init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("userID");
    if (token != null) {
      print('Token: $token');
      Get.offAll(() => LandingScreen());
    } else {
      print("No token");
      Get.offAll(() => const UserAuthentication());
    }
  }

  @override
  void initState() {
    checkIfLogin();
    Timer(
      const Duration(seconds: 2),
      () {
        // Get.off(() => isLogin ? LandingScreen() : const UserAuthentication());
        // Get.to(() => const Registration());
        _init();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // backgroundColor: Colors.green,
      backgroundColor: Color(0xFF008037),
      body: SafeArea(
        child: Center(
          child: Image(
            image: AssetImage("assets/noQ.gif"),
          ),
        ),
      ),
    );
  }
}
