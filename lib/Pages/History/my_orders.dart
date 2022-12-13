import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: const Center(
        child: Text(
          "My Orders",
        ),
      ),
    );
  }
}
