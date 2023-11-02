import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noq/Pages/History/store_listing.dart';
import 'package:noq/Pages/checkout_qr_code.dart';
import 'package:noq/Pages/landing_screen.dart';
import '../Controllers/cartController.dart';
import '../Models/product_model.dart';

// ignore: must_be_immutable
class CartScreen extends StatefulWidget {
  CartController cartController = Get.find();

  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  _buildCartItem(CartController cartController, int index) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          "/productDescriptionScreen",
          arguments: {
            "barcodeDigit":
                cartController.cartProduct[index].product.productID.toString()
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
        child: Container(
          height: 110.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                offset: Offset(0, 2),
                blurRadius: 20.0,
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    width: 100.0,
                    height: 104.0,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                      ),
                      // color: Colors.green.shade300,
                      color: cartController
                          .cartProduct[index].product.backgroundColor
                          .toColor(),
                      // color: Color(0xFFA5DAEA),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image(
                        image: NetworkImage(
                          cartController.cartProduct[index].product.imageUrl
                              .toString(),
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width:
                                (MediaQuery.of(context).size.width - 160) - 50,
                            // color: Colors.red,
                            padding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 10.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartController
                                      .cartProduct[index].product.productName
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                    color: Color(0xFF2A2941),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.attach_money,
                                      size: 10.0,
                                    ),
                                    const SizedBox(width: 2.0),
                                    Text(
                                      cartController.cartProduct[index].product
                                          .productPrice
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        color: Color(0xFF2A2941),
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 30,
                            height: 80.0,
                            child: Column(
                              children: [
                                // Increase Item Button
                                InkWell(
                                  onTap: () {
                                    cartController.increaseItemsInCart(
                                      Product(
                                        productID: cartController
                                            .cartProduct[index]
                                            .product
                                            .productID,
                                        productName: cartController
                                            .cartProduct[index]
                                            .product
                                            .productName,
                                        productPrice: cartController
                                            .cartProduct[index]
                                            .product
                                            .productPrice,
                                        imageUrl: cartController
                                            .cartProduct[index]
                                            .product
                                            .imageUrl,
                                        backgroundColor: cartController
                                            .cartProduct[index]
                                            .product
                                            .backgroundColor,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green.shade200,
                                      // color: Color(0xFFA5DAEA),
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.black,
                                      size: 18.0,
                                    ),
                                  ),
                                ),
                                // Number of items present in the cart
                                Expanded(
                                  child: Center(
                                    child: Obx(
                                      () => Text(
                                        cartController.cartProduct[index].qty
                                            .toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // Decrease Item Button
                                InkWell(
                                  onTap: () {
                                    if (cartController.cartProduct[index].qty ==
                                        1) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AdvanceCustomAlert(
                                              index: index);
                                        },
                                      );
                                    } else {
                                      cartController.decreaseItemsInCart(
                                        Product(
                                          productID: cartController
                                              .cartProduct[index]
                                              .product
                                              .productID,
                                          productName: cartController
                                              .cartProduct[index]
                                              .product
                                              .productName,
                                          productPrice: cartController
                                              .cartProduct[index]
                                              .product
                                              .productPrice,
                                          imageUrl: cartController
                                              .cartProduct[index]
                                              .product
                                              .imageUrl,
                                          backgroundColor: cartController
                                              .cartProduct[index]
                                              .product
                                              .backgroundColor,
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(0, -1),
                                          blurRadius: 20.0,
                                        ),
                                      ],
                                    ),
                                    child: Obx(
                                      () => cartController
                                                  .cartProduct[index].qty >
                                              1
                                          ? const Icon(
                                              Icons.remove,
                                              color: Colors.black,
                                              size: 18.0,
                                            )
                                          : Icon(
                                              Icons.delete,
                                              color: Colors.red.shade300,
                                              size: 18.0,
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  var db = FirebaseFirestore.instance.collection("user");
  var auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          iconSize: 20.0,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return DeleteCartAlert();
              },
            );
          },
        ),
        title: const Text(
          "Your Cart",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          SizedBox(
            width: 50,
            height: 40,
            child: Center(
              child: IconButton(
                onPressed: () => {Get.to(() => const StoreListing())},
                icon: const Icon(
                  Icons.store,
                  color: Colors.black,
                ),
                iconSize: 30.0,
              ),
            ),
          ),
          SizedBox(
            width: 50,
            height: 40,
            child: Center(
              child: IconButton(
                onPressed: () => {Get.toNamed("/scannerScreen")},
                icon: const Icon(
                  Icons.document_scanner,
                  color: Colors.black,
                ),
                iconSize: 30.0,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: db
                  .doc(auth.currentUser?.phoneNumber?.replaceAll("+91", ""))
                  .get(),
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(8.0),
                      child: const CircularProgressIndicator(
                        color: Colors.green,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  );
                }
                return InkWell(
                  onTap: () => {Get.toNamed("/profileScreen")},
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "assets/img_avatar.png",
                        ),
                      ),
                    ),
                  ),
                );
              }),
          const SizedBox(width: 10.0)
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - 240,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            stops: [0, 1],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFF4CAF50),
            ],
          ),
        ),
        child: widget.cartController.products.length == 0
            ? Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.2,
                    vertical: MediaQuery.of(context).size.height * 0.1),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage("assets/empty.png"),
                        fit: BoxFit.contain,
                      ),
                      Text(
                        "Add Some Items.!",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 22.5,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Obx(
                () => ListView.builder(
                  itemCount: widget.cartController.products.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return _buildCartItem(widget.cartController, index);
                  },
                ),
              ),
      ),
      bottomSheet: Container(
        height: 160.0,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, -1),
              blurRadius: 20.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      // Taxes
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Total Items: ",
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            const SizedBox(width: 5.0),
                            widget.cartController.products.length == 0
                                ? const Text(
                                    "NA",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Obx(
                                    () => Text(
                                      widget.cartController.products.length
                                          .toString()
                                          .padLeft(2, "0"),
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      // Total Quantity
                      Expanded(
                        // width: MediaQuery.of(context).size.width / 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Quantity: ",
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            const SizedBox(width: 5.0),
                            widget.cartController.totalQuantity == 0
                                ? const Text(
                                    "NA",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Obx(
                                    () => Text(
                                      widget.cartController.totalQuantity
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 10.0,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.attach_money,
                        size: 16,
                      ),
                      Expanded(
                        child: widget.cartController.totalPrice == 0
                            ? Text(
                                widget.cartController.totalPrice
                                    .toString()
                                    .padRight(2, "0"),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              )
                            : Obx(
                                () => Text(
                                  widget.cartController.totalPrice
                                      .toString()
                                      .padLeft(2, "0"),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.green.shade700,
                          ),
                          overlayColor: MaterialStateProperty.all(
                            Colors.green.shade600,
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 13.0,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Get.to(() => const CheckoutQRCode());
                        },
                        child: const Row(
                          children: [
                            Text(
                              "Checkout",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.exit_to_app,
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
      ),
    );
  }
}

// Dialog Box for Product removal from cart
// ignore: must_be_immutable
class AdvanceCustomAlert extends StatelessWidget {
  final int index;
  CartController cartController = Get.find();

  AdvanceCustomAlert({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.red.shade100,
                  blurRadius: 20.0,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            height: 200,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
            child: Column(
              children: [
                Text(
                  "Remove Item",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.red.shade300),
                ),
                const SizedBox(height: 15),
                Text(
                  "Are you sure you want to remove this item?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey.shade300),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red.shade500),
                          ),
                          onPressed: () {
                            Get.back();
                            cartController.decreaseItemsInCart(
                              Product(
                                productID: cartController
                                    .cartProduct[index].product.productID,
                                productName: cartController
                                    .cartProduct[index].product.productName,
                                productPrice: cartController
                                    .cartProduct[index].product.productPrice,
                                imageUrl: cartController
                                    .cartProduct[index].product.imageUrl,
                                backgroundColor: cartController
                                    .cartProduct[index].product.backgroundColor,
                              ),
                            );
                          },
                          child: const Text(
                            "Remove",
                            style: TextStyle(
                              color: Colors.white,
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
          const Positioned(
            top: -40,
            child: CircleAvatar(
              backgroundColor: Colors.redAccent,
              radius: 40,
              child: Icon(
                Icons.warning_amber,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Dialog Box for Deleting Cart
// ignore: must_be_immutable
class DeleteCartAlert extends StatelessWidget {
  CartController cartController = Get.find();

  DeleteCartAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.red,
                  blurRadius: 20.0,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            height: 250,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
            child: Column(
              children: [
                Text(
                  "Delete Cart",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.red.shade300),
                ),
                const SizedBox(height: 15),
                Text(
                  "Are you sure you want to Delete this Cart?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 15),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 12,
                      color: Colors.red,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "You Won't be able to retrieve the ",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                const Text(
                  "added products!",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey.shade300),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red.shade500),
                          ),
                          onPressed: () {
                            Get.delete<CartController>();
                            Get.off(() => LandingScreen());
                          },
                          child: const Text(
                            "Remove",
                            style: TextStyle(
                              color: Colors.white,
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
          const Positioned(
            top: -40,
            child: CircleAvatar(
              backgroundColor: Colors.redAccent,
              radius: 40,
              child: Icon(
                Icons.warning_amber,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
