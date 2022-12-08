import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noq/Pages/Scanner/scanner_screen.dart';
import 'package:noq/Pages/Scanner/dummy.dart';
import 'package:noq/Pages/cart_screen.dart';
import 'package:noq/Pages/Login/final_login_screen.dart';
import 'package:noq/Pages/landing_screen.dart';
import 'package:noq/Pages/Login/OTP/otp_screen.dart';
import 'package:noq/Pages/ProductDescription/product_description_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
      () => {
        Get.off(() => ScannerScreen())
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
