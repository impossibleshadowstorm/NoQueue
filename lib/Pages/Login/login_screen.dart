import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noq/Animations/FadeAnimation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor - 0.15;
    print(textScale);

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(vertical: 15.00),
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
                Colors.white,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
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
                          fontSize: 52.00 * textScale
                        ),
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
              const SizedBox(height: 20.00),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60.00),
                      topRight: Radius.circular(60.00),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween   ,
                      children: [
                        const SizedBox(height: 30),
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
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                // Email Field
                                // Container(
                                //   padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
                                //   decoration: BoxDecoration(
                                //     border: Border(
                                //       bottom: BorderSide(
                                //           color: Colors.grey.shade200),
                                //     ),
                                //   ),
                                //   child: const TextField(
                                //
                                //     decoration: InputDecoration(
                                //       hintText: "Name",
                                //       hintStyle: TextStyle(color: Colors.grey),
                                //       border: InputBorder.none,
                                //     ),
                                //   ),
                                // ),

                                // Password Field
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200),
                                    ),
                                  ),
                                  child: const TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
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
                        FadeAnimation(
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
                              ],),

                            child: const Center(
                              child: Text(
                                "Get OTP",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 60),
                        // Don't have an Account
                        // FadeAnimation(
                        //   1.7,
                        //   const Text(
                        //     "Don't have an Account?",
                        //     style: TextStyle(color: Colors.grey),
                        //   ),
                        // ),
                        // const SizedBox(height: 10),
                        // // Create Account Button
                        // FadeAnimation(
                        //   1.6,
                        //   Container(
                        //     height: 50,
                        //     margin: const EdgeInsets.symmetric(horizontal: 50),
                        //     decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(50),
                        //         color: Colors.orange.shade700),
                        //     child: const Center(
                        //       child: Text(
                        //         "Create Account",
                        //         style: TextStyle(
                        //             color: Colors.white,
                        //             fontSize: 16.0,
                        //             fontWeight: FontWeight.bold),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //         child: FadeAnimation(
                        //       1.8,
                        //       Container(
                        //         height: 50.0,
                        //         decoration: BoxDecoration(
                        //           color: Colors.blue,
                        //           borderRadius: BorderRadius.circular(50.0),
                        //         ),
                        //         child: const Center(
                        //           child: Text(
                        //             "Facebook",
                        //             style: TextStyle(
                        //                 color: Colors.white,
                        //                 fontSize: 16.0,
                        //                 fontWeight: FontWeight.bold),
                        //           ),
                        //         ),
                        //       ),
                        //     )),
                        //     const SizedBox(width: 30.0),
                        //     Expanded(
                        //       child: FadeAnimation(
                        //         1.9,
                        //         Container(
                        //           height: 50.0,
                        //           decoration: BoxDecoration(
                        //             color: Colors.black,
                        //             borderRadius: BorderRadius.circular(50.0),
                        //           ),
                        //           child: const Center(
                        //             child: Text(
                        //               "Github",
                        //               style: TextStyle(
                        //                   color: Colors.white,
                        //                   fontSize: 16.0,
                        //                   fontWeight: FontWeight.bold),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:noq/Controllers/cartController.dart';
// import 'package:noq/Models/product_model.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';
//
// class ProductDescriptionScreen extends StatefulWidget {
//   CartController cartController = Get.find();
//
//   ProductDescriptionScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ProductDescriptionScreen> createState() =>
//       _ProductDescriptionScreenState();
// }
//
// class _ProductDescriptionScreenState extends State<ProductDescriptionScreen> {
//   var db = FirebaseFirestore.instance
//       .collection("product")
//       .doc(Get.arguments?['barcodeDigit']);
//   final panelController = PanelController();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   // Future<dynamic> getData() async {
//   //   final DocumentReference document =   FirebaseFirestore.instance.collection("listofprods").document('ac1');
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//           future: db.get(),
//           builder: (_, snapshot) {
//             if (!snapshot.hasData) {
//               return CircularProgressIndicator();
//             }
//
//             // final docRef = db.collection("product").doc("0641606975894");
//             // docRef.get().then((DocumentSnapshot doc) {
//             //   final data = doc.data() as Map<String, dynamic>;
//             // });
//             return Stack(
//               children: [
//
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 25.0, vertical: 60),
//                   height: MediaQuery.of(context).size.height * 0.6,
//                   decoration: BoxDecoration(
//                     color: Colors.red.shade300,
//                   ),
//                   child: Container(
//                     height: double.infinity,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: NetworkImage(
//                           // "https://firebasestorage.googleapis.com/v0/b/noqueue-35cdf.appspot.com/o/cherries.png?alt=media&token=ca7ebf5a-1713-473e-b18f-f1cf2457a82f",
//                           snapshot.data!.data()!["image"],
//                         ),
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   left: 30,
//                   top: 30 + MediaQuery.of(context).padding.top,
//                   child: InkWell(
//                     onTap: () {},
//                     child: ClipOval(
//                       child: Container(
//                         height: 42,
//                         width: 41,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.25),
//                               offset: const Offset(0, 4),
//                               blurRadius: 8,
//                             ),
//                           ],
//                         ),
//                         child: const Center(
//                           child: Icon(
//                             Icons.arrow_back_sharp,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(40),
//                       topRight: Radius.circular(40),
//                     ),
//                     child: Container(
//                       height: MediaQuery.of(context).size.height * 0.45,
//                       width: MediaQuery.of(context).size.width,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(40),
//                           topRight: Radius.circular(40),
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             offset: const Offset(0, -4),
//                             blurRadius: 8,
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(
//                               top: 20.0,
//                               left: 30.0,
//                               right: 30.0,
//                             ),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     // "Cherries ${Get.arguments?['barcodeDigit']}",
//                                     snapshot.data!.data()!["name"],
//                                     style: GoogleFonts.ptSans(
//                                       fontSize: 36.0,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.red.shade900,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(
//                               top: 20,
//                               left: 30,
//                               right: 30,
//                             ),
//                             child: Row(
//                               children: [
//                                 Text(
//                                   "INR ${snapshot.data!.data()!["price"]}",
//                                   style: GoogleFonts.ptSans(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 // Text(
//                                 //   " / 1 KG",
//                                 //   style: GoogleFonts.ptSans(
//                                 //     fontSize: 20,
//                                 //   ),
//                                 // ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(
//                               top: 10,
//                               left: 30,
//                               right: 30,
//                             ),
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 4.0, horizontal: 8),
//                               decoration: BoxDecoration(
//                                 color: const Color.fromRGBO(63, 200, 101, 1),
//                                 borderRadius: BorderRadius.circular(5.0),
//                               ),
//                               child: Text(
//                                 "Shipped directly from farmers",
//                                 style: GoogleFonts.ptSans(
//                                   color: Colors.white,
//                                   fontSize: 14.0,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     widget.cartController.decreaseNumOfItems();
//                                   },
//                                   child: Container(
//                                     height: 49,
//                                     width: 49,
//                                     decoration: BoxDecoration(
//                                       color: const Color.fromRGBO(
//                                           228, 228, 228, 1),
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         "-",
//                                         style: GoogleFonts.ptSans(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 20.0,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 49,
//                                   width: 100,
//                                   child: Center(
//                                     child: Obx(
//                                           () => Text(
//                                         widget.cartController
//                                             .numOfItemsInDescription
//                                             .toString()
//                                             .padLeft(2, "0"),
//                                         style: GoogleFonts.ptSans(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 20.0,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     widget.cartController.increaseNumOfItems();
//                                   },
//                                   child: Container(
//                                     height: 49,
//                                     width: 49,
//                                     decoration: BoxDecoration(
//                                       color:
//                                       const Color.fromRGBO(243, 175, 45, 1),
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         "+",
//                                         style: GoogleFonts.ptSans(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 20.0,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             width: MediaQuery.of(context).size.height,
//                             padding: const EdgeInsets.symmetric(
//                               vertical: 30.0,
//                               horizontal: 30.0,
//                             ),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: const BorderRadius.only(
//                                 topRight: Radius.circular(20),
//                                 topLeft: Radius.circular(20),
//                               ),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(.07),
//                                   offset: const Offset(0, -3),
//                                   blurRadius: 12,
//                                 )
//                               ],
//                             ),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Total",
//                                         style: GoogleFonts.ptSans(
//                                           fontSize: 14.0,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                       Text(
//                                         "INR ${snapshot.data!.data()!["price"]}",
//                                         style: GoogleFonts.ptSans(
//                                           fontSize: 20.0,
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Material(
//                                   color: const Color.fromRGBO(243, 175, 45, 1),
//                                   borderRadius: BorderRadius.circular(10),
//                                   child: InkWell(
//                                     onTap: () {
//                                       widget.cartController.addToCart(
//                                         const Product(
//                                           productID: 123,
//                                           productName: "abc",
//                                           productPrice: 123.5,
//                                           imageUrl: "assets/logo1.png",
//                                           backgroundColor: "red",
//                                         ),
//                                       );
//                                       Get.toNamed("/cartScreen");
//                                     },
//                                     borderRadius: BorderRadius.circular(10),
//                                     child: Container(
//                                       padding: const EdgeInsets.symmetric(
//                                         vertical: 10,
//                                         horizontal: 20.0,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         borderRadius:
//                                         BorderRadius.circular(10.0),
//                                       ),
//                                       child: Text(
//                                         "Add to Cart",
//                                         style: GoogleFonts.ptSans(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             );
//           }),
//     );
//   }
// }
//
