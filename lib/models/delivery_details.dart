class DeliveryDetails {
  final String name;
  final String city;
  final String state;
  final String email;
  final String number;
  final String country;
  final String pinCode;
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
