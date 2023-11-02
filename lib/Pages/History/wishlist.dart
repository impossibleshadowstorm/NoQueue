import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:noq/Pages/History/Wishlist%20Edit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

enum Actions { delete }

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  var db = FirebaseFirestore.instance.collection("user");
  var auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.5.w),
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
                      "Add Items",
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
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: db
                          .doc(auth.currentUser?.phoneNumber
                              ?.replaceAll("+91", ""))
                          .collection("items_list")
                          .snapshots(), // Use .snapshots() to get a stream
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              String title =
                                  snapshot.data!.docs[index].data()["content"];
                              if (title.length > 25) {
                                title = title.substring(0, 25);
                              }
                              title = title.replaceAll("\\n", "\n");
                              return InkWell(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                onTap: () {
                                  Get.to(
                                    () => WishlistEdit(
                                      id: snapshot.data!.docs[index].id,
                                    ),
                                  );
                                },
                                child: Slidable(
                                  endActionPane: ActionPane(
                                    motion: const BehindMotion(),
                                    children: [
                                      SlidableAction(
                                        backgroundColor: Colors.red,
                                        icon: Icons.delete,
                                        label: "Delete",
                                        onPressed: (context) => _onDismissed(
                                            index,
                                            Actions.delete,
                                            snapshot.data!.docs[index].id),
                                      )
                                    ],
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 2.w),
                                    height: 80,
                                    width: 100.w,
                                    color: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2.w, horizontal: 2.w),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 70,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green,
                                          ),
                                          child: Center(
                                            child: Text(
                                              snapshot.data!.docs[index]
                                                          .data()["content"] !=
                                                      ""
                                                  ? snapshot.data!.docs[index]
                                                      .data()["content"]
                                                      .toString()
                                                      .capitalize!
                                                      .substring(0, 1)
                                                  : "?",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 2.5.w),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                title.capitalizeFirst!,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15.sp,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 100.w,
                                                child: Text(
                                                  snapshot.data!.docs[index]
                                                              .data()["date"] !=
                                                          null
                                                      ? formatDate(snapshot
                                                          .data!.docs[index]
                                                          .data()["date"])
                                                      : "",
                                                  textAlign: TextAlign.end,
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13.sp,
                                                  ),
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
                            },
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.green,
                            ),
                          );
                        }
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () async {
          try {
            final documentReference = db
                .doc(auth.currentUser?.phoneNumber?.replaceAll("+91", ""))
                .collection("items_list")
                .doc(); // Automatically generates a new document ID

            // Create a map for the new document
            final data = {
              "content": "",
              "date": FieldValue.serverTimestamp(), // Set the current timestamp
            };

            await documentReference.set(data);

            // Show a success Snackbar
            showSuccess();
          } catch (error) {
            print("Error creating a new document: $error");
          }
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green,
          ),
          child: const Center(
            child: Icon(
              Icons.add,
              size: 25,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _onDismissed(int index, Actions action, String id) {
    try {
      final documentReference = db
          .doc(auth.currentUser?.phoneNumber?.replaceAll("+91", ""))
          .collection("items_list")
          .doc(id);

      documentReference.delete();
      showDeletionSuccess();

      // Handle any other actions or updates as needed
    } catch (error) {
      log("Error deleting document: $error");
    }
  }

  void showDeletionSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("List Deleted successfully"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void showSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("New List Item Created successfully"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  String formatDate(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }
}
