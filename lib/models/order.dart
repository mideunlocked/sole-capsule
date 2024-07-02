import 'package:cloud_firestore/cloud_firestore.dart';

import 'delivery_details.dart';
import 'product.dart';

class Orders {
  final String id;
  final int color;
  final double price;
  final int quantity;
  final String status;
  final String prodId;
  final Product? product;
  final Timestamp timestamp;
  final String paymentMethod;
  final DeliveryDetails deliveryDetails;

  const Orders({
    required this.id,
    required this.color,
    required this.price,
    required this.status,
    required this.prodId,
    required this.product,
    required this.quantity,
    required this.timestamp,
    required this.paymentMethod,
    required this.deliveryDetails,
  });

  factory Orders.fromJson({
    required Map<String, dynamic> json,
    required Product? product,
  }) {
    return Orders(
      id: json['id'] as String,
      status: json['status'] as String,
      color: json['color'] as int,
      price: json['price'] as double,
      prodId: json['prodId'] as String,
      quantity: json['quantity'] as int,
      product: product,
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
}
