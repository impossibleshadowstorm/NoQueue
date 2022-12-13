import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Controllers/userRegistrationController.dart';

class Registration extends StatefulWidget {
  final String uid;

  const Registration({Key? key, required this.uid}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  // UserRegistrationController userRegistrationController = Get.find();
  UserRegistrationController userRegistrationController =
      Get.put(UserRegistrationController());
  var auth = FirebaseAuth.instance;

  // Future signUp() async {
  //   if (passwordConfirmed()) {
  //     //Add user details
  //     addUserDetails(
  //       _firstNameController.text.trim(),
  //       _lastNameController.text.trim(),
  //       int.parse(_phoneNoController.text.trim()),
  //       _emailController.text.trim(),
  //     );
  //   }
  // }

  // Future addUserDetails(
  //     String firstName, String lastName, int phoneNo, String email) async {
  //   await FirebaseFirestore.instance.collection('user').add({
  //     'first name': firstName,
  //     'last name': lastName,
  //     'phoneNo': phoneNo,
  //     'email': email,
  //   });
  // }

  // bool passwordConfirmed() {
  //   if (_passwordController.text.trim() ==
  //       _confirmpasswordController.text.trim()) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(14.0),
          color: Colors.white,
          child: ListView(
            children: [
              // Top Registration Image
              SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: SvgPicture.asset(
                  "assets/sign_up_image.svg",
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 50),

              Text(
                "User Registration",
                textAlign: TextAlign.center,
                style: GoogleFonts.aBeeZee(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              // Input fields
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //FIRSTNAME INPUT
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.48,
                      color: Colors.white54,
                      child: TextField(
                        controller:
                            userRegistrationController.firstNameController,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.green.shade800,
                            size: 18,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green.shade700,
                            ),
                          ),
                          hintText: "First Name",
                          hintStyle: TextStyle(
                            color: Colors.green.shade700,
                          ),
                          filled: true,
                        ),
                      ),
                    ),
                    // LASTNAME INPUT
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.44,
                      color: Colors.white54,
                      child: TextField(
                        controller:
                            userRegistrationController.lastNameController,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green.shade700,
                            ),
                          ),
                          hintText: "Last Name",
                          hintStyle: TextStyle(
                            color: Colors.green.shade700,
                          ),
                          filled: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Phone Number Input
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                color: Colors.white54,
                child: TextField(
                  controller: userRegistrationController.phoneController,
                  keyboardType: TextInputType.phone,
                  enabled: false,
                  style: TextStyle(
                    color: Colors.green.shade800,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone,
                      size: 18,
                      color: Colors.green.shade800,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green.shade700,
                      ),
                    ),
                    hintText: "+91 ${auth.currentUser?.phoneNumber.toString()}",
                    hintStyle: TextStyle(
                      color: Colors.green.shade700,
                    ),
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              //EMAIL INPUT
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                color: Colors.white54,
                child: TextField(
                  controller: userRegistrationController.emailController,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      size: 18,
                      color: Colors.green.shade800,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green.shade700,
                      ),
                    ),
                    hintText: "Email",
                    hintStyle: TextStyle(
                      color: Colors.green.shade700,
                    ),
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Address Input
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                color: Colors.white54,
                child: TextField(
                  controller: userRegistrationController.addressController,
                  maxLines: null,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green.shade700,
                      ),
                    ),
                    hintText: "Address [Optional]",
                    hintStyle: TextStyle(
                      color: Colors.green.shade700,
                    ),
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Container(
              //   height: 50,
              //   width: MediaQuery.of(context).size.width,
              //   color: Colors.white54,
              //   child: TextField(
              //     obscureText: true,
              //     controller: _confirmpasswordController,
              //     style: const TextStyle(
              //       color: Colors.black,
              //     ),
              //     decoration: InputDecoration(
              //       focusedBorder: UnderlineInputBorder(
              //         borderSide: BorderSide(
              //           color: Colors.green.shade700,
              //         ),
              //       ),
              //       hintText: "Confirm Password",
              //       hintStyle: TextStyle(
              //         color: Colors.green.shade700,
              //       ),
              //       filled: true,
              //     ),
              //   ),
              // ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    userRegistrationController.setUserData();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.green.shade700),
                  ),
                  // style: ElevatedButton.styleFrom(
                  //   elevation: 12.0,
                  //   textStyle: const TextStyle(color: Colors.white),
                  // ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
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
