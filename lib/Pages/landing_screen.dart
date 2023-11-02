import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noq/Animations/FadeAnimation.dart';
import 'package:noq/Controllers/authController.dart';
import 'package:noq/Controllers/cartController.dart';
import 'package:noq/Pages/Login/final_login_screen.dart';
import 'package:noq/Pages/profile_screen.dart';

class LandingScreen extends StatefulWidget {
  LandingScreen({Key? key}) : super(key: key);
  CartController cartController = Get.put(CartController());

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            FadeAnimation(
              1,
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    stops: [0, 1],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0xFF4CAF50),
                    ],
                  ),
                  // gradient: LinearGradient(
                  //   begin: Alignment.topLeft,
                  //   colors: [
                  //     Colors.green.shade700,
                  //     Colors.green.shade600,
                  //     Colors.green.shade500,
                  //     Colors.green.shade300,
                  //   ],
                  // ),
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage(
                      "assets/start-shopping.png",
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 50.0,
                        vertical: 50.0,
                      ),
                    ),
                    FadeAnimation(
                      2,
                      TextButton(
                        onPressed: () {
                          // authController.logoutUser();
                          Get.to(() => const ProfileScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25.0),
                                topLeft: Radius.circular(25.0),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30.0,
                                vertical: 15.0,
                              ),
                              child: Icon(
                                Icons.person,
                                // Icons.power_settings_new_outlined,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FadeAnimation(
                1.3,
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    padding: const EdgeInsets.only(
                      right: 20,
                      bottom: 60,
                      left: 30,
                    ),
                    child: Material(
                      elevation: 8,
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Welcome Back To Your App",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Text(
                                    "Don't Wait for your turn. Let's ",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.acme(
                                        fontSize: 15.0, color: Colors.green),
                                  ),
                                  FadeAnimation(
                                    1.5,
                                    TextButton(
                                      style: ButtonStyle(
                                        overlayColor: MaterialStateProperty.all(
                                            Colors.transparent),
                                      ),
                                      onPressed: () {
                                        Get.toNamed("/cartScreen");
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.green,
                                        ),
                                        child: Center(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                'Start Shopping',
                                                style: GoogleFonts.ptSans(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const Icon(
                                                Icons.arrow_forward_sharp,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
