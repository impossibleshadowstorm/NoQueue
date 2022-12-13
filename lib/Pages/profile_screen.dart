import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noq/Controllers/authController.dart';
import 'package:noq/Pages/History/my_orders.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthController authController = Get.find();
  var db = FirebaseFirestore.instance.collection("user");
  var auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    DateTime date = DateTime.now();
    print("${date.year} ${date.month} ${date.day}");
    print("${date.hour} ${date.minute} ${date.second}");
    print(auth.currentUser?.phoneNumber?.replaceAll("+91", ""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: db
                .doc(auth.currentUser?.phoneNumber?.replaceAll("+91", ""))
                .get(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                    backgroundColor: Colors.white,
                  ),
                );
              }
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 10.0),
                child: Column(
                  children: [
                    // Appbar
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      // color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => {Get.back()},
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              size: 20.0,
                              color: Color(0xFF008037),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Bio Image
                    SizedBox(
                      height: 200,
                      child: Row(
                        children: [
                          // Profile Image Container
                          Container(
                            width:
                                (MediaQuery.of(context).size.width - 80) * 0.4,
                            height: 130,
                            padding: const EdgeInsets.all(8),
                            // Profile Picture
                            child: Stack(
                              children: [
                                Container(
                                  height: 130,
                                  width: 130,
                                  decoration: const BoxDecoration(
                                    // color: Colors.cyanAccent,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage("assets/circle.png"),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    height: 87.5,
                                    width: 87.5,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          snapshot.data!
                                                  .data()!["profileImage"] ?? (snapshot.data!.data()![
                                                          "profileImage"] ==
                                                      "Mr."
                                                  ? "https://www.w3schools.com/howto/img_avatar.png"
                                                  : "https://www.w3schools.com/howto/img_avatar2.png"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Divider
                          const VerticalDivider(
                            width: 30,
                            thickness: 1.3,
                            indent: 75,
                            endIndent: 75,
                            color: Colors.black12,
                          ),
                          // Mobile-Email
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "+91 ${snapshot.data!.data()!["phone"]}",
                                  textDirection: TextDirection.ltr,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  snapshot.data!.data()!["email"],
                                  textDirection: TextDirection.ltr,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Name title
                    SizedBox(
                      height: 170,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Gender
                          Text(
                            snapshot.data!.data()!["title"],
                            textDirection: TextDirection.ltr,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          // Name
                          Text(
                            snapshot.data!.data()!["name"],
                            textDirection: TextDirection.ltr,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black38,
                              fontSize: 50,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Set of Cart Wallet
                          Column(
                            children: [
                              // My Cart
                              InkWell(
                                onTap: () {
                                  Get.toNamed("/cartScreen");
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              // color: Color(0xFFFFF0E6),
                                              color: Colors.green.shade50,
                                            ),
                                            child: Icon(
                                              Icons.shopping_cart,
                                              size: 20.0,
                                              color: Colors.green.shade700,
                                              // color: Color(0xFFFFA977),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          const Text(
                                            "My cart",
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green.shade50,
                                      ),
                                      child: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 20.0,
                                        color: Colors.green.shade900,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Wallet
                              InkWell(
                                onTap: () {
                                  Get.to(() => const MyOrders());
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 60,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFFECEAFF),
                                            ),
                                            child: const Icon(
                                              Icons.history_sharp,
                                              size: 20.0,
                                              color: Color(0xFF5520FF),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          const Text(
                                            "My Orders",
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xFFECEAFF),
                                      ),
                                      child: const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 20.0,
                                        color: Color(0xFF5520FF),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Settings
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Container(
                              //       child: Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           Container(
                              //             width: 60,
                              //             height: 60,
                              //             decoration: const BoxDecoration(
                              //               shape: BoxShape.circle,
                              //               color: Color(0xFFE6F6FF),
                              //             ),
                              //             child: const Icon(
                              //               Icons.settings,
                              //               size: 20.0,
                              //               color: Color(0xFF009DEC),
                              //             ),
                              //           ),
                              //           const SizedBox(width: 10),
                              //           const Text(
                              //             "Settings",
                              //             textDirection: TextDirection.ltr,
                              //             style: TextStyle(
                              //                 color: Colors.black,
                              //                 fontSize: 18.0,
                              //                 fontWeight: FontWeight.w400),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //     Container(
                              //       height: 50,
                              //       width: 50,
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(10),
                              //         color: Color(0xFFE6F6FF),
                              //       ),
                              //       child: const Icon(
                              //         Icons.arrow_forward_ios_rounded,
                              //         size: 20.0,
                              //         color: Color(0xFF009DEC),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              const SizedBox(height: 10),
                            ],
                          ),

                          // Sign Out
                          InkWell(
                            onTap: () {
                              authController.logoutUser();
                            },
                            child: Container(
                              width: 120,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black12,
                              ),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.output_sharp,
                                    size: 20.0,
                                    color: Color(0xFFFC2052),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Sign Out",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFFC2052),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
