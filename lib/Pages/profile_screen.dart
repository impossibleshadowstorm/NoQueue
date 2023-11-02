import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noq/Controllers/authController.dart';
import 'package:noq/Pages/History/my_orders.dart';
import 'package:noq/Pages/History/wishlist.dart';
import 'package:noq/Pages/cart_screen.dart';

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
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            "assets/img_avatar.png"
                                            // image: NetworkImage(
                                            //   snapshot.data!
                                            //           .data()!["profileImage"] ??
                                            //       (snapshot.data!
                                            //                   .data()!["title"] ==
                                            //               "Mr."
                                            //           ? "https://www.w3schools.com/howto/img_avatar.png"
                                            //           : "https://www.w3schools.com/howto/img_avatar2.png"),
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
                            toTitleCase(snapshot.data!.data()!["name"]),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              optionsRow(
                                Icons.shopping_cart,
                                "My Cart",
                                Colors.green.shade50,
                                Colors.green.shade700,
                                CartScreen(),
                              ),
                              optionsRow(
                                Icons.shopping_cart,
                                "My Orders",
                                const Color(0xFFECEAFF),
                                const Color(0xFF5520FF),
                                const MyOrders(),
                              ),
                              optionsRow(
                                Icons.favorite,
                                "Make Items List",
                                Colors.green.shade50,
                                const Color(0xFF36685b),
                                const Wishlist(),
                              ),
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
                                color: const Color(0xFFF8ffff),
                              ),
                              child: const Row(
                                children: [
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

  String toTitleCase(String text) {
    if (text.isEmpty) {
      return "";
    }

    List<String> words = text.split(" ");
    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }

    return words.join(" ");
  }

  Widget optionsRow(IconData iconData, String title, Color bgColor,
      Color iconColor, Widget navigate) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(() => navigate);
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: bgColor,
                    ),
                    child: Icon(
                      iconData,
                      size: 20.0,
                      color: iconColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: bgColor,
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20.0,
                  color: iconColor,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
