class Product {
  final int productID;
  final String productName;
  final double productPrice;
  final String imageUrl;
  final String backgroundColor;

  const Product({
    required this.productID,
    required this.productName,
    required this.productPrice,
    required this.imageUrl,
    required this.backgroundColor,
  });

  // static const List<Product> products = [
  //   Product(
  //     productID: 123,
  //     productName: "abc",
  //     productPrice: 122.00,
  //     imageUrl: "assets/logo.png",
  //     backgroundColor: "red",
  //   ),
  //   Product(
  //     productID: 1234,
  //     productName: "abcd",
  //     productPrice: 123.00,
  //     imageUrl: "assets/logo.png",
  //     backgroundColor: "red",
  //   ),
  //   Product(
  //     productID: 12345,
  //     productName: "abcde",
  //     productPrice: 124.00,
  //     imageUrl: "assets/logo.png",
  //     backgroundColor: "red",
  //   ),
  //   Product(
  //     productID: 123456,
  //     productName: "abdefc",
  //     productPrice: 125.00,
  //     imageUrl: "assets/logo.png",
  //     backgroundColor: "red",
  //   ),
  // ];
}
