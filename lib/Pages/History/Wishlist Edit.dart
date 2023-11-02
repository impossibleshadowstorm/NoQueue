import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WishlistEdit extends StatefulWidget {
  final String id;

  const WishlistEdit({super.key, required this.id});

  @override
  State<WishlistEdit> createState() => _WishlistEditState();
}

class _WishlistEditState extends State<WishlistEdit> {
  var db = FirebaseFirestore.instance.collection("user");
  var auth = FirebaseAuth.instance;
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 100.h,
          width: 100.w,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              SizedBox(
                height: AppBar().preferredSize.height,
                width: 100.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "MatchStick",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 5.w)
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: db
                      .doc(auth.currentUser?.phoneNumber?.replaceAll("+91", ""))
                      .collection("items_list")
                      .doc(widget.id)
                      .get(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      String title = snapshot.data!.data()!["content"];
                      title = title.replaceAll("\\n", "\n");
                      contentController.text = title;

                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.5.w, vertical: 2.5.w),
                        child: TextFormField(
                          controller: contentController,
                          maxLines: 37,
                          decoration: const InputDecoration.collapsed(
                            hintText: "Enter You list Of Items..",
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () async {
          try {
            // Get a reference to the Firestore document
            final documentReference = db
                .doc(auth.currentUser?.phoneNumber?.replaceAll("+91", ""))
                .collection("items_list")
                .doc(widget.id);

            // Update the "content" field with the text from contentController
            await documentReference.update({
              "content": contentController.text,
            });

            // Show a success message or perform any other necessary actions
            // (e.g., navigate back to a previous screen)
            log("Content updated successfully");
            showSuccess();
          } catch (error) {
            // Handle errors, e.g., show an error message
            log("Error updating content: $error");
          }
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Icons.save,
              color: Colors.white,
              size: 20.sp,
            ),
          ),
        ),
      ),
    );
  }

  void showSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Content updated successfully"),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
