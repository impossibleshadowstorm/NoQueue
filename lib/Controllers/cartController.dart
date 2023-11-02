import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:noq/Models/cart_product_list_model.dart';
import 'dart:convert';
import '../Models/product_model.dart';

class CartController extends GetxController {
  var auth = FirebaseAuth.instance;
  var expanded = 0.obs;

  // Cart Products List
  List<CartProductListModel> cartProduct =
      List<CartProductListModel>.empty().obs;

  String createQR() {
    Map<String, dynamic> checkout = {
      "cartProduct": cartProduct,
      "totalQuantity": totalQuantity,
      "totalItem": cartProduct.length,
      "userMobile": auth.currentUser!.phoneNumber,
      "cartTotal": totalPrice,
    };
    String str = jsonEncode(checkout);
    return str;
  }

  // Number of Items in Product Description
  var numOfItemsInDescription = 1.obs;

  // Count For total Number of Cart Products
  // get totalNumberOfCartItems => cartProduct.length.obs;

  int get totalQuantity =>
      cartProduct.fold(0, (totalQty, element) => totalQty + element.qty);

  // Function Increases the Number of items in Product Description
  void increaseNumOfItems() {
    if (numOfItemsInDescription.value > 0) numOfItemsInDescription.value++;
  }

  // Function Decreases the Number of items in Product Description
  void decreaseNumOfItems() {
    if (numOfItemsInDescription.value > 1) numOfItemsInDescription.value--;
  }

  // Function Increases the Number of items in Cart
  increaseItemsInCart(Product product) {
    final index = cartProduct.indexWhere(
        (element) => element.product.productID == product.productID);

    cartProduct[index] = CartProductListModel(
      product: product,
      qty: (1 + cartProduct[index].qty),
    );
  }

  // Function Decreases the Number of items in Cart
  decreaseItemsInCart(Product product) {
    final index = cartProduct.indexWhere(
        (element) => element.product.productID == product.productID);

    if (cartProduct[index].qty > 1) {
      cartProduct[index] = CartProductListModel(
        product: product,
        qty: (cartProduct[index].qty - 1),
      );
    } else {
      cartProduct.removeAt(index);
    }
  }

  // Adds the products to cart from Product Description Screen
  addToCart(Product product) {
    final index = cartProduct.indexWhere((element) {
      return element.product.productID == product.productID;
    });

    if (index > -1) {
      cartProduct[index] = CartProductListModel(
        product: product,
        qty: (numOfItemsInDescription.value + cartProduct[index].qty),
      );
    } else {
      cartProduct.add(
        CartProductListModel(
            product: product, qty: numOfItemsInDescription.value),
      );
    }

    // Initializes again the Number of items in product description screen to 1
    numOfItemsInDescription.value = 1;
  }

  // Adds all the price of the cart
  double get totalPrice => cartProduct.fold(
      0,
      (totalPc, product) =>
          totalPc + (product.product.productPrice * product.qty));

  // Returns all Products present in the cart
  get products => cartProduct;
}
