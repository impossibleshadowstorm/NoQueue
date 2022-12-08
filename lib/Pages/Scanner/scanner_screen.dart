import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noq/Pages/Scanner/scanner_bottom_sheet_panel.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:noq/Controllers/scannerController.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                panelBuilder: (sc) => ScannerBottomSheetPanel(
                  sc: sc,
                  panelController: panelController,
                ),
              ),
              Container(
                  padding: EdgeInsets.all(10),
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

// Widget buildControlButtons() =>Row(
//   children: [
//     IconButton()
//   ],
// );

// Widget buildResult() =>
//     Container(padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8), color: Colors.white,),
//       child: (result != null)
//           ? Text(
//           'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!
//               .code}')
//           : Text('Scan a code',),);

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        // widget.scannerController.result.value = scanData;
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
