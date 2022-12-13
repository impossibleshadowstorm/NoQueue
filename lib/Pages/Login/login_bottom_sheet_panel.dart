import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:noq/Controllers/authController.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:noq/Pages/Login/OTP/otp_screen.dart';
import '../../Animations/FadeAnimation.dart';

class LoginBottomSheetPanel extends StatefulWidget {
  final ScrollController sc;
  final PanelController panelController;

  const LoginBottomSheetPanel(
      {Key? key, required this.sc, required this.panelController})
      : super(key: key);

  @override
  State<LoginBottomSheetPanel> createState() => _LoginBottomSheetPanelState();

  static String verify = "";
}

class _LoginBottomSheetPanelState extends State<LoginBottomSheetPanel> {
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    authController.countryCode.text = "+91";
    super.initState();
  }

  Widget build(BuildContext context) {
    return ListView(
      controller: widget.sc,
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(
          height: 15,
        ),
        buildDragHandle(),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 10),
              // Text Fields
              FadeAnimation(
                1.4,
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.shade100,
                        blurRadius: 20.0,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Phone Number Field
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 5),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade200),
                          ),
                        ),
                        child: TextField(
                          controller: authController.phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.green,
                            ),
                            hintText: "Phone Number",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Login Button
              GestureDetector(
                onTap: () async {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: authController.countryCode.text +
                        authController.phoneController.text,
                    verificationCompleted: (
                      PhoneAuthCredential credential,
                    ) {},
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (String verificationId, int? resendToken) {
                      authController.verify = verificationId;
                      Get.to(() =>
                          OTPScreen(verify: LoginBottomSheetPanel.verify));
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );
                },
                child: FadeAnimation(
                  1.6,
                  Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.green,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.shade300,
                          blurRadius: 20.0,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "Get OTP",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDragHandle() {
    return GestureDetector(
      onTap: togglePanel,
      child: Center(
        child: Container(
          width: 30,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }

  void togglePanel() => widget.panelController.isPanelOpen
      ? widget.panelController.close()
      : widget.panelController.open();

  Widget inputPhoneNumber() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green,
            ),
          ),
          prefixIcon: const Icon(
            Icons.onetwothree,
            color: Colors.green,
          ),
          hintText: "Enter the Barcode Digits",
          hintStyle: const TextStyle(
            color: Colors.green,
          ),
          filled: true,
          fillColor: Colors.green.shade100,
        ),
      ),
    );
  }
}
