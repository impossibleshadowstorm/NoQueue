import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noq/Controllers/authController.dart';
import 'package:noq/Controllers/cartController.dart';
import 'package:noq/Controllers/scannerController.dart';
import 'package:noq/Pages/cart_screen.dart';
import 'package:noq/Pages/Login/final_login_screen.dart';
import 'package:noq/Pages/landing_screen.dart';
import 'package:noq/Pages/ProductDescription/product_description_screen.dart';
import 'package:noq/Pages/profile_screen.dart';
import 'package:noq/Pages/Scanner/scanner_screen.dart';
import 'package:noq/Pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "NoQueue",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  CartController cartController = Get.put(CartController());
  ScannerController scannerController = Get.put(ScannerController());
  AuthController authController = Get.put(AuthController());

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, type) {
      return GetMaterialApp(
        title: 'NoQ',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/",
        getPages: [
          GetPage(name: "/", page: () => const SplashScreen()),
          GetPage(name: "/cartScreen", page: () => CartScreen()),
          GetPage(name: "/profileScreen", page: () => const ProfileScreen()),
          GetPage(name: "/scannerScreen", page: () => ScannerScreen()),
          GetPage(name: "/landingScreen", page: () => LandingScreen()),
          // GetPage(name: "/otpScreen", page: () => const OTPScreen()),
          GetPage(
              name: "/userAuthentication",
              page: () => const UserAuthentication()),
          GetPage(
              name: "/productDescriptionScreen",
              page: () => ProductDescriptionScreen()),
        ],
      );
    });
  }
}
