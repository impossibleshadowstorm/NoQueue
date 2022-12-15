import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../Controllers/cartController.dart';
import '../Models/product_model.dart';
import 'landing_screen.dart';

class CheckoutQRCode extends StatefulWidget {
  const CheckoutQRCode({Key? key}) : super(key: key);

  @override
  State<CheckoutQRCode> createState() => _CheckoutQRCodeState();
}

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

class _CheckoutQRCodeState extends State<CheckoutQRCode> {
  CartController cartController = Get.find();
  final panelController = PanelController();

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
            borderRadius: BorderRadius.circular(35.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                offset: Offset(0, 1),
                blurRadius: 10.0,
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
                        topLeft: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SlidingUpPanel(
              controller: panelController,
              minHeight: MediaQuery.of(context).size.height * 0.55,
              maxHeight: MediaQuery.of(context).size.height * 0.7,
              parallaxEnabled: true,
              parallaxOffset: 0.1,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18.0),
              ),
              body: Column(
                children: [
                  // Container(
                  //   color: Colors.red,
                  //   width: MediaQuery.of(context).size.width,
                  //   child: Icon(Icons.arrow_back_sharp),
                  // ),
                  const SizedBox(height: 50),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    height: MediaQuery.of(context).size.height * 0.31,
                    width: MediaQuery.of(context).size.width * 0.62,
                    child: Center(
                      child: Obx(() {
                        return QrImage(
                          size: 300,
                          backgroundColor: Colors.white,
                          data: cartController.createQR(),
                        );
                      }),
                    ),
                  ),
                ],
              ),
              panelBuilder: (sc) => ListView(
                physics: const BouncingScrollPhysics(),
                controller: sc,
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 15),
                  buildDragHandle(),
                  Container(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                width: MediaQuery.of(context).size.width,
                                child: Obx(
                                  () => ListView.builder(
                                    itemCount: cartController.products.length,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return _buildCartItem(
                                          cartController, index);
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 80.0,
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
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0,
                            horizontal: 10.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Total : ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Icon(
                                Icons.currency_rupee_sharp,
                                size: 16,
                              ),
                              Expanded(
                                child: cartController.totalPrice == 0
                                    ? Text(
                                        cartController.totalPrice
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
                                          cartController.totalPrice
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: const Icon(
                    Icons.arrow_back_sharp,
                    color: Colors.white,
                    size: 21,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0.0,
        label: const Text("Done"),
        backgroundColor: Colors.green.shade900,
        icon: const Icon(Icons.thumb_up_alt_rounded),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return DeleteCartAlert();
            },
          );
        },
      ),
    );
    // return Scaffold(
    //   body: SafeArea(
    //     child: Center(
    //       child: QrImage(
    //         size: 200,
    //         backgroundColor: Colors.white,
    //         data: cartController.createQR(),
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget buildDragHandle() {
    return GestureDetector(
      onTap: togglePanel,
      child: Center(
        child: Container(
          width: 30,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }

  void togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();
}

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
                  color: Colors.black,
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
                    color: Colors.red.shade300,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Are you done with the shopping?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.error_outline,
                      size: 12,
                      color: Colors.red,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "You Won't be able to retrieve this ",
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
                  "QR Code again..!",
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
