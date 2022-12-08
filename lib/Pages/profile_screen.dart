import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
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
                      onPressed: () => {
                        Get.back()
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 20.0,
                        color: Color(0xFF008037),
                      ),
                    ),
                    IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.dehaze_rounded,
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
                    Container(
                      width: (MediaQuery.of(context).size.width - 80) * 0.4,
                      height: 130,
                      padding: const EdgeInsets.all(8),
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
                                  image: NetworkImage(
                                    "https://www.w3schools.com/howto/img_avatar2.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const VerticalDivider(
                      width: 30,
                      thickness: 1.3,
                      indent: 75,
                      endIndent: 75,
                      color: Colors.black12,
                    ),

                    //Name-Email
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "+91 62007797711",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "kajalrituraj2002@gmail.com",
                          textDirection: TextDirection.ltr,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                            fontFamily: "r",
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ),

              // Name title
              SizedBox(
                // color: Colors.blue,
                height: 170,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Mr.",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 50,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "Awesome",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        color: Colors.black26,
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
                    Container(
                      child: Column(
                        children: [
                          // My Cart
                          InkWell(
                            onTap: () {
                              Get.toNamed("/cartScreen");
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        Icons.account_balance_wallet_outlined,
                                        size: 20.0,
                                        color: Color(0xFF5520FF),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      "Wallet",
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
                          const SizedBox(height: 10),

                          // Settings
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        color: Color(0xFFE6F6FF),
                                      ),
                                      child: const Icon(
                                        Icons.settings,
                                        size: 20.0,
                                        color: Color(0xFF009DEC),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      "Settings",
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFFE6F6FF),
                                ),
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20.0,
                                  color: Color(0xFF009DEC),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),

                    // Sign Out
                    Container(
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // return Scaffold(
    //   body: SafeArea(
    //     child: Container(
    //       height: MediaQuery.of(context).size.height,
    //       width: MediaQuery.of(context).size.width,
    //       padding: const EdgeInsets.all(20.0),
    //       child: Column(
    //         children: [
    //           SizedBox(
    //             width: MediaQuery.of(context).size.width,
    //             child: Row(
    //               children: [
    //                 IconButton(
    //                   onPressed: () => {Get.back()},
    //                   icon: const Icon(
    //                     Icons.arrow_back_ios,
    //                     size: 20.0,
    //                     color: Colors.black,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
