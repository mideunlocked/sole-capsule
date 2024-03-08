import 'package:cloud_firestore/cloud_firestore.dart';

class Discount {
  final String code;
  final Timestamp validityPeriod;
  final String percentageOff;

  Discount({
    required this.code,
    required this.validityPeriod,
    required this.percentageOff,
  });

  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
      code: json['code'] as String,
      validityPeriod: json['validityPeriod'] as Timestamp,
      percentageOff: json['percentageOff'] as String,
    );
  }

  String calculateDiscountPrice({
    required String price,
  }) {
    double intPrice = double.parse(price);

    double discountedPrice = intPrice * double.parse(percentageOff) / 100;

    double newPrice = intPrice - discountedPrice;

    return newPrice.toString();
  }
}
