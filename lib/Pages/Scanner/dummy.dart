import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noq/Pages/Scanner/scanner_bottom_sheet_panel.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:noq/Controllers/scannerController.dart';

class QRCODESCANNER extends StatefulWidget {
  const QRCODESCANNER({Key? key}) : super(key: key);

  @override
  State<QRCODESCANNER> createState() => _QRCODESCANNERState();
}

class _QRCODESCANNERState extends State<QRCODESCANNER> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
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
      body: Stack(
        children: <Widget>[
          QRView(
            overlay: QrScannerOverlayShape(
              cutOutSize: MediaQuery.of(context).size.width * 0.8,
              borderRadius: 10,
              borderColor: Colors.red,
              borderLength: 20,
              borderWidth: 10,
            ),
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          Positioned(
            bottom: 10,
            child: buildResult(),
          )
        ],
      ),
    );
  }

  Widget buildResult() => Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white24,
      ),
      child: Text(
        result != null ? 'Result: ${result!.code}' : "Scan a Code",
        maxLines: 3,
      ));

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
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
