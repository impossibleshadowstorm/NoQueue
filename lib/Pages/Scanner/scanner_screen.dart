import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:noq/Controllers/scannerController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class ScannerScreen extends StatefulWidget {
  ScannerController scannerController = Get.find();

  ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  final panelController = PanelController();
  TextEditingController barcodeInputController = TextEditingController();

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  // @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  final _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              SlidingUpPanel(
                controller: panelController,
                minHeight: MediaQuery.of(context).size.height * 0.25,
                maxHeight: MediaQuery.of(context).size.height * 0.7,
                parallaxEnabled: true,
                parallaxOffset: 0.5,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(18.0),
                ),
                body: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderWidth: 10,
                    borderLength: 20,
                    borderRadius: 10,
                    borderColor: Colors.green,
                    cutOutBottomOffset: MediaQuery.of(context).size.width * 0.3,
                    cutOutSize: MediaQuery.of(context).size.width * 0.8,
                  ),
                ),
                panelBuilder: (sc) => getBottomSheet(sc),
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  height: 50,
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => {Get.back()},
                        icon: const Icon(
                          Icons.close,
                          color: Color(0xFFA5DAEA),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                await controller?.toggleFlash();
                                setState(() {});
                              },
                              icon: FutureBuilder<bool?>(
                                future: controller?.getFlashStatus(),
                                builder: (context, snapshot) {
                                  if (snapshot.data != null) {
                                    return Icon(
                                        snapshot.data!
                                            ? Icons.flashlight_on_outlined
                                            : Icons.flashlight_off_outlined,
                                        color: const Color(0xFFA5DAEA));
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ),
                            IconButton(
                              onPressed: () => {},
                              icon: FutureBuilder(
                                future: controller?.getCameraInfo(),
                                builder: (context, snapshot) {
                                  if (snapshot.data != null) {
                                    return const Icon(
                                      Icons.switch_camera_outlined,
                                      color: Color(0xFFA5DAEA),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
              // Container(
              //   // flex: 1,
              //   child: Center(
              //     child: (result != null)
              //
              //         ? Text(
              //             'Barcode Type: ${result!.format}   Data: ${result!.code}')
              //         : Text('Scan a code'),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  // Function to fetch data or show error if data isn't present
  Future getDoc(String value) async {
    var db =
        await FirebaseFirestore.instance.collection("product").doc(value).get();

    if (db.data() == null) {
      Get.snackbar(
        "Oh Snap",
        "The Product Id is not Valid. Scan it Using Scanner"
        // SnackBar(
        //   content: Stack(
        //     clipBehavior: Clip.none,
        //     children: [
        //       Container(
        //         height: 90,
        //         padding: const EdgeInsets.all(16),
        //         decoration: const BoxDecoration(
        //           color: Color(0xFFC72C41),
        //           borderRadius: BorderRadius.all(
        //             Radius.circular(20),
        //           ),
        //         ),
        //         child: Row(
        //           children: [
        //             const SizedBox(width: 48),
        //             Expanded(
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: const [
        //                   Text(
        //                     "Oh Snap!",
        //                     style: TextStyle(
        //                         fontSize: 18,
        //                         color: Colors.white,
        //                         fontWeight: FontWeight.bold),
        //                   ),
        //                   Spacer(),
        //                   Text(
        //                     "The Product Id is not Valid. Scan it Using Scanner",
        //                     maxLines: 2,
        //                     overflow: TextOverflow.ellipsis,
        //                     style: TextStyle(
        //                       fontSize: 12,
        //                       fontWeight: FontWeight.w500,
        //                       color: Colors.white,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Positioned(
        //         bottom: 0,
        //         // left: 0,
        //         child: ClipRRect(
        //           borderRadius: const BorderRadius.only(
        //             bottomLeft: Radius.circular(20),
        //           ),
        //           child: SvgPicture.asset(
        //             "assets/bubbles.svg",
        //             color: const Color(0xFF801336),
        //             height: 70,
        //             width: 45,
        //           ),
        //         ),
        //       ),
        //       Positioned(
        //         top: -20,
        //         left: 0,
        //         child: Stack(
        //           alignment: Alignment.center,
        //           children: [
        //             SvgPicture.asset(
        //               "assets/chat.svg",
        //               color: Colors.red.shade900,
        //               height: 48,
        //               width: 40,
        //             ),
        //             const Positioned(
        //               top: 15,
        //               child: Icon(
        //                 Icons.close,
        //                 color: Colors.white,
        //                 size: 16,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        //   behavior: SnackBarBehavior.floating,
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
      );
    }
    else {
      // db.data()?.values.map((e) => print(e));
      Get.toNamed(
        "/productDescriptionScreen",
        arguments: {"barcodeDigit": value},
      );
    }
  }

  Widget getBottomSheet(ScrollController sc) {
    return ListView(
      controller: sc,
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(height: 15),
        buildDragHandle(),
        const SizedBox(height: 10),
        buildQRInputNumber(),
        Container(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.green.shade500,
              ),
              overlayColor: MaterialStateProperty.all(
                Colors.green.shade600,
              ),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 13.0,
                ),
              ),
            ),
            onPressed: () async {
              await getDoc(barcodeInputController.text);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Submit",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });
      print("scannerdata");
      print(result!.code);
      if (result!.code != null) await getDoc(result!.code.toString());
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
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

  void togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();

  Widget buildQRInputNumber() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        controller: barcodeInputController,
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
          hintStyle: const TextStyle(color: Colors.green),
          filled: true,
          fillColor: Colors.green.shade100,
        ),
      ),
    );
  }
}
