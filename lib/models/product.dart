class Product {
  final String id;
  final String name;
  final String description;
  final String productDetails;
  final List<dynamic> colors;
  final double price;
  final double? discount;
  final bool isOutOfStock;
  final List<dynamic> productImages;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.colors,
    required this.discount,
    required this.description,
    required this.productDetails,
    required this.isOutOfStock,
    required this.productImages,
  });

  factory Product.fromJSon({required Map<String, dynamic> json}) {
    double discount = double.parse(json['discount'].toString());
    double price = double.parse(json['price'].toString());

    return Product(
        id: json['id'] as String,
        name: json['name'] as String,
        price: price,
        colors: json['colors'] as List<dynamic>,
        discount: discount,
        description: json['description'] as String,
        productDetails: json['productDetails'] as String,
        isOutOfStock: json['isOutOfStock'] as bool,
        productImages: json['productImages'] as List<dynamic>);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'colors': colors,
      'discount': discount,
      'description': description,
      'productDetails': productDetails,
      'isOutOfStock': isOutOfStock,
      'productImages': productImages,
    };
  }
}
