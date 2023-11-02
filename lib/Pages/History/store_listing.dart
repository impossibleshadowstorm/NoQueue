import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noq/Controllers/cartController.dart';
import 'package:noq/Pages/ProductDescription/product_description_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class StoreListing extends StatefulWidget {
  const StoreListing({super.key});

  @override
  State<StoreListing> createState() => _StoreListingState();
}

// extension ColorExtension on String {
//   toColor() {
//     var hexColor = replaceAll("#", "");
//     if (hexColor.length == 6) {
//       hexColor = "FF$hexColor";
//     }
//     if (hexColor.length == 8) {
//       return Color(int.parse("0x$hexColor"));
//     }
//   }
// }

class _StoreListingState extends State<StoreListing> {
  var db = FirebaseFirestore.instance.collection("product");
  var auth = FirebaseAuth.instance;
  final CartController _cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 100.h,
          width: 100.w,
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
                      "Store Listing",
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
              Expanded(child: accordionList())
            ],
          ),
        ),
      ),
    );
  }

  getDataFromDb() {}

  Widget accordionList() {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: db.get(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            Map<String, List<DocumentSnapshot>> categoryMap = {};
            for (DocumentSnapshot<Map<String, dynamic>> document
                in snapshot.data!.docs) {
              String category = document.data()!['category'];
              // Create a list for the category if it doesn't exist in the map
              categoryMap.putIfAbsent(category, () => []);

              // Add the document to the category's list
              categoryMap[category]!.add(document);
            }
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: categoryMap.keys.toList().length,
                itemBuilder: (context, index) {
                  return Obx(() {
                    return ExpansionPanelList(
                        expansionCallback: (int idx, bool isExpanded) {
                          _cartController.expanded.value = index;
                        },
                        children: [
                          ExpansionPanel(
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  title: Text(categoryMap.keys
                                      .toList()[index]
                                      .capitalizeFirst!),
                                );
                              },
                              body: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: categoryMap[
                                        categoryMap.keys.toList()[index]]!
                                    .length,
                                itemBuilder: (context, idx) {
                                  var document = categoryMap[
                                      categoryMap.keys.toList()[index]];
                                  return Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.w, vertical: 2.5.w),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: document![idx]
                                                    ["backgroundColor"]
                                                .toString()
                                                .toColor(),
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  document[idx]["image"]),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.5.w,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                document![idx]["name"],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "Floor No: ${document[idx]["floor"]}",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "Rack No: ${document[idx]["rack"]}",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              isExpanded:
                                  _cartController.expanded.value == index),
                        ]);
                  });
                });
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        });
  }
}
