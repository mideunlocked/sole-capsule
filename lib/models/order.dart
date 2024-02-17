import 'package:provider/provider.dart';

import '../main.dart';
import '../provider/product_provider.dart';
import 'product.dart';

class Orders {
  final String id;
  final int color;
  final double price;
  final int quantity;
  final String status;
  final String prodId;
  final String paymentMethod;

  const Orders({
    required this.id,
    required this.color,
    required this.price,
    required this.status,
    required this.prodId,
    required this.quantity,
    required this.paymentMethod,
  });

  factory Orders.fromJson({
    required Map<String, dynamic> json,
  }) {
    return Orders(
      id: json['id'] as String,
      status: json['status'] as String,
      color: json['color'] as int,
      price: json['price'] as double,
      prodId: json['prodId'] as String,
      quantity: json['quantity'] as int,
      paymentMethod: json['paymentMethod'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'color': color,
      'price': price,
      'prodId': prodId,
      'quantity': quantity,
      'paymentMethod': paymentMethod,
    };
  }

  double calculateTotalPrice() {
    double totalPrice = 0;
    totalPrice = price * quantity;

    return totalPrice;
  }

  Future<Product?> getOrderProduct() async {
    var productPvr = Provider.of<ProductProvider>(
      MainApp.navigatorKey.currentContext!,
      listen: false,
    );

    return await productPvr.getProduct(prodId: prodId);
  }
}
