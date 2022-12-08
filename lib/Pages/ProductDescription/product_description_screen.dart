import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noq/Controllers/cartController.dart';
import 'package:noq/Models/product_model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProductDescriptionScreen extends StatefulWidget {
  CartController cartController = Get.find();

  ProductDescriptionScreen({Key? key}) : super(key: key);

  @override
  State<ProductDescriptionScreen> createState() =>
      _ProductDescriptionScreenState();
}

class _ProductDescriptionScreenState extends State<ProductDescriptionScreen> {
  var db = FirebaseFirestore.instance
      .collection("product")
      .doc(Get.arguments?['barcodeDigit']);
  final panelController = PanelController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // Future<dynamic> getData() async {
  //   final DocumentReference document =   FirebaseFirestore.instance.collection("listofprods").document('ac1');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: db.get(),
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            // final docRef = db.collection("product").doc("0641606975894");
            // docRef.get().then((DocumentSnapshot doc) {
            //   final data = doc.data() as Map<String, dynamic>;
            // });
            else{
              return Stack(
                children: [
                  SlidingUpPanel(
                    controller: panelController,
                    minHeight: MediaQuery.of(context).size.height * 0.45,
                    maxHeight: MediaQuery.of(context).size.height * 0.55,
                    parallaxEnabled: true,
                    parallaxOffset: 0.5,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(18.0),
                    ),
                    body: Container(
                      width: MediaQuery.of(context).size.width,
                      // padding: const EdgeInsets.symmetric(
                      //     horizontal: 25.0, vertical: 10),
                      padding: const EdgeInsets.only(
                        left: 25.0,
                        right: 25.0,
                        bottom: 10,
                        top: 52,
                      ),
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: Colors.red.shade300,
                      ),
                      child: Column(
                        children: [
                          Container(
                            height:
                                MediaQuery.of(context).size.height * 0.55 - 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  // "https://firebasestorage.googleapis.com/v0/b/noqueue-35cdf.appspot.com/o/cherries.png?alt=media&token=ca7ebf5a-1713-473e-b18f-f1cf2457a82f",
                                  snapshot.data!.data()!["image"],
                                ),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                    panelBuilder: (sc) => ListView(
                      controller: sc,
                      padding: EdgeInsets.zero,
                      children: [
                        const SizedBox(height: 15),
                        buildDragHandle(),
                        const SizedBox(height: 10),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 20.0,
                                  left: 30.0,
                                  right: 30.0,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        snapshot.data!.data()!["name"],
                                        style: GoogleFonts.ptSans(
                                          fontSize: 23.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red.shade900,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                  left: 30,
                                  right: 30,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "INR ${snapshot.data!.data()!["price"]}",
                                      style: GoogleFonts.ptSans(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  left: 30,
                                  right: 30,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(63, 200, 101, 1),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Text(
                                    "Shipped directly from farmers",
                                    style: GoogleFonts.ptSans(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        widget.cartController
                                            .decreaseNumOfItems();
                                      },
                                      child: Container(
                                        height: 49,
                                        width: 49,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              228, 228, 228, 1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "-",
                                            style: GoogleFonts.ptSans(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 49,
                                      width: 100,
                                      child: Center(
                                        child: Obx(
                                          () => Text(
                                            widget.cartController
                                                .numOfItemsInDescription
                                                .toString()
                                                .padLeft(2, "0"),
                                            style: GoogleFonts.ptSans(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        widget.cartController
                                            .increaseNumOfItems();
                                      },
                                      child: Container(
                                        height: 49,
                                        width: 49,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              243, 175, 45, 1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "+",
                                            style: GoogleFonts.ptSans(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.height,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 30.0,
                                  horizontal: 30.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(.07),
                                      offset: const Offset(0, -3),
                                      blurRadius: 12,
                                    )
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Total",
                                            style: GoogleFonts.ptSans(
                                              fontSize: 14.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            "INR ${snapshot.data!.data()!["price"]}",
                                            style: GoogleFonts.ptSans(
                                              fontSize: 20.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Material(
                                      color:
                                          const Color.fromRGBO(243, 175, 45, 1),
                                      borderRadius: BorderRadius.circular(10),
                                      child: InkWell(
                                        onTap: () {
                                          Type type = snapshot.data!
                                              .data()!["price"]
                                              .runtimeType;
                                          print(type);
                                          widget.cartController.addToCart(
                                            Product(
                                              productID:
                                                  snapshot.data!.data()!["id"],
                                              productName: snapshot.data!
                                                  .data()!["name"]
                                                  .toString(),
                                              productPrice: snapshot.data!
                                                  .data()!["price"]
                                                  .toDouble(),
                                              imageUrl: snapshot.data!
                                                  .data()!["image"]
                                                  .toString(),
                                              backgroundColor: snapshot.data!
                                                  .data()!["backgroundColor"]
                                                  .toString(),
                                            ),
                                          );
                                          Get.toNamed("/cartScreen");
                                        },
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 20.0,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Text(
                                            "Add to Cart",
                                            style: GoogleFonts.ptSans(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
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
                      ],
                    ),
                    //     ProductDescriptionBottomSheetPanel(
                    //   sc: sc,
                    //   panelController: panelController,
                    // ),
                  ),
                  Positioned(
                    left: 30,
                    top: 30 + MediaQuery.of(context).padding.top,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: ClipOval(
                        child: Container(
                          height: 42,
                          width: 41,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                offset: const Offset(0, 4),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_back_sharp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
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

  void togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();
}
