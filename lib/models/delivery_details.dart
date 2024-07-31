import 'package:hive/hive.dart';

part 'delivery_details.g.dart';

@HiveType(typeId: 3)
class DeliveryDetails {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String city;

  @HiveField(2)
  final String state;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final String number;

  @HiveField(5)
  final String country;

  @HiveField(6)
  final String pinCode;

  @HiveField(7)
  final String address;

  const DeliveryDetails({
    required this.name,
    required this.city,
    required this.state,
    required this.email,
    required this.number,
    required this.country,
    required this.pinCode,
    required this.address,
  });

  factory DeliveryDetails.fromJson({
    required Map<String, dynamic> json,
  }) {
    return DeliveryDetails(
      name: json['name'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      email: json['email'] as String,
      number: json['number'] as String,
      country: json['country'] as String,
      pinCode: json['pinCode'] as String,
      address: json['address'] as String,
    );
  }

  Map<String, dynamic> toJSon() {
    return {
      'name': name,
      'city': city,
      'state': state,
      'email': email,
      'number': number,
      'country': country,
      'pinCode': pinCode,
      'address': address,
    };
  }
}
