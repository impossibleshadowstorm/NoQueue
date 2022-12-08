import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noq/Pages/Login/OTP/otp_bottom_sheet_panel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../Animations/FadeAnimation.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      body: Container(
        // padding: EdgeInsets.only(top: 60),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            SlidingUpPanel(
              controller: panelController,
              minHeight: MediaQuery.of(context).size.height * 0.30,
              maxHeight: MediaQuery.of(context).size.height * 0.7,
              parallaxEnabled: true,
              parallaxOffset: 0.1,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18.0),
              ),
              body: Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.symmetric(vertical: 50.00),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [
                      Colors.green.shade900,
                      Colors.green.shade800,
                      Colors.green.shade600,
                      Colors.green.shade400,
                      Colors.green.shade200,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeAnimation(
                            1,
                            Text(
                              "No Queue",
                              style: GoogleFonts.bebasNeue(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 52.00 * textScale),
                            ),
                          ),
                          FadeAnimation(
                            1.2,
                            const Text(
                              "Don't Wait For Your turn.",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.00,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40.00),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        alignment: Alignment.center,
                        children: const [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 170,
                            color: Colors.white,
                          ),
                          Positioned(
                            top: 40,
                            child: Icon(
                              Icons.access_time,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              panelBuilder: (sc) => OTPBottomSheetPanel(
                sc: sc,
                panelController: panelController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
