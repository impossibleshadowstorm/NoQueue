import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.android,
                size: 100.00,
              ),
              const SizedBox(height: 75.0),

              Text(
                "Hello Again!",
                style: GoogleFonts.bebasNeue(fontSize: 52.00),
              ),
              const SizedBox(height: 10.0),
              const Text(
                "Welcome back, you've been missed!",
                style: TextStyle(
                  fontSize: 20.00,
                ),
              ),
              const SizedBox(height: 50.0),

              //  Email Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10.0),
              //  Password Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10.0),
              //  Sign In Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25.0),
              // Not a member?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Not a member?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    " Register now",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(40.0),
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
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 20.0,
                      ),
                    ),
                    IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.dehaze_rounded,
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
                                  image: AssetImage("assets/circle.png")),
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
                      Text("Mr.",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 50,
                              fontWeight: FontWeight.w700)),
                      Text("Awesome",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              color: Colors.black26,
                              fontSize: 50,
                              fontFamily: "r")),
                    ],
                  )),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          // My Cart
                          SizedBox(
                            height: 80,
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 140,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 60,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFFFFF0E6),
                                            ),
                                            child: const Icon(
                                              Icons.shopping_cart,
                                              size: 20.0,
                                              color: Color(0xFFFFA977),
                                            ),

                                          ),
                                          const Text("My cart",
                                              textDirection: TextDirection.ltr,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                              )),
                                        ],
                                      )),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black12,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 20.0,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          // My cart 2
                          SizedBox(
                            height: 80,
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 140,
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
                                              Icons
                                                  .account_balance_wallet_outlined,
                                              size: 20.0,
                                              color: Color(0xFF5520FF),
                                            ),

                                          ),
                                          const Text("My cart",
                                              textDirection: TextDirection.ltr,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                              )),
                                        ],
                                      )),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black12,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 20.0,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          // Settings
                          SizedBox(
                            height: 80,
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 140,
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
                                        const Text(
                                          "Settings",
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
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
                                      color: Colors.black12,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 20.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Sign Out
                    Container(
                      width: 120,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
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
                          SizedBox(width: 8,),
                          Text(
                            "Sign Out",
                            style: TextStyle(fontWeight: FontWeight.w700),
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
  }
}

