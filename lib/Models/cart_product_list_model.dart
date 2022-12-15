
import 'package:noq/Models/product_model.dart';

class CartProductListModel {
  final Product product;
  final int qty;

  CartProductListModel({required this.product, required this.qty});

  Map toJson() {
    Map product = (this.product != null ? this.product.toJson() : null) as Map;

    return {'product': product, "qty": qty};
  }
}
