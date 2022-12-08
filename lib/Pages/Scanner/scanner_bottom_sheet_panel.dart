import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScannerBottomSheetPanel extends StatefulWidget {
  final ScrollController sc;
  final PanelController panelController;

  const ScannerBottomSheetPanel(
      {Key? key, required this.sc, required this.panelController})
      : super(key: key);

  @override
  State<ScannerBottomSheetPanel> createState() =>
      _ScannerBottomSheetPanelState();
}

class _ScannerBottomSheetPanelState extends State<ScannerBottomSheetPanel> {
  TextEditingController barcodeInputController = TextEditingController();

  Future getDoc(String value) async {
    var db =
        await FirebaseFirestore.instance.collection("product").doc(value).get();

    if (db.data() == null) {
      print("Doesn't exist!");
    } else {
      db.data()?.values.map((e) => print(e));
      print(" Exist");
      // Get.toNamed(
      //   "/productDescriptionScreen",
      //   arguments: {"barcodeDigit": value},
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.sc,
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
              print(barcodeInputController.text);
              await getDoc(barcodeInputController.text);
              // Get.toNamed(
              //   "/productDescriptionScreen",
              //   arguments: {"barcodeDigit": barcodeInputController.text},
              // );
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
