import 'package:provider/provider.dart';

import '../helpers/calculate_discount.dart';
import '../main.dart';
import '../provider/product_provider.dart';
import 'product.dart';

class Cart {
  final String id;
  final int quantity;
  final String prodId;

  const Cart({
    required this.id,
    required this.prodId,
    required this.quantity,
  });

  factory Cart.fromJson({
    required Map<String, dynamic> json,
  }) {
    return Cart(
      id: json['id'] as String,
      prodId: json['prodId'] as String,
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson({
    required String id,
    required Cart cart,
  }) {
    return {
      'id': id,
      'prodId': cart.prodId,
      'quantity': cart.quantity,
    };
  }

  double totalCartPrice() {
    Product product = cartProduct();
    String priceString = CalculateDiscount.calculateDiscount(
      product.price,
      product.discount ?? 0,
    );

    double price = double.parse(priceString);

    double totalPrice = price * quantity;

    return totalPrice;
  }

  Product cartProduct() {
    var productPvr =
        Provider.of<ProductProvider>(MainApp.navigatorKey.currentContext!);

    Product product = productPvr.products.firstWhere(
      (e) => e.id == prodId,
    );

    return product;
  }
}