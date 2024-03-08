import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:sole_capsule/models/delivery_details.dart';

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
  final Timestamp timestamp;
  final String paymentMethod;
  final DeliveryDetails deliveryDetails;

  const Orders({
    required this.id,
    required this.color,
    required this.price,
    required this.status,
    required this.prodId,
    required this.quantity,
    required this.timestamp,
    required this.paymentMethod,
    required this.deliveryDetails,
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
      timestamp: json['timestamp'] as Timestamp,
      paymentMethod: json['paymentMethod'] as String,
      deliveryDetails: DeliveryDetails.fromJson(json: json['deliveryDetails']),
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
      'timestamp': Timestamp.now(),
      'paymentMethod': paymentMethod,
      'deliveryDetails': deliveryDetails.toJSon(),
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
