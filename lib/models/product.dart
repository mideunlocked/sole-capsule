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
    return Product(
        id: json['id'] as String,
        name: json['name'] as String,
        price: json['price'] as double,
        colors: json['colors'] as List<dynamic>,
        discount: json['discount'] as double?,
        description: json['description'] as String,
        productDetails: json['productDetails'] as String,
        isOutOfStock: json['isOutOfStock'] as bool,
        productImages: json['productImages'] as List<dynamic>);
  }

  Map<String, dynamic> toJson({required Product prod}) {
    return {
      'id': prod.id,
      'name': prod.name,
      'price': prod.price,
      'colors': prod.colors,
      'discount': prod.discount,
      'description': prod.description,
      'productDetails': prod.productDetails,
      'isOutOfStock': prod.isOutOfStock,
      'productImages': prod.productImages,
    };
  }
}

List<Product> products = const [
  Product(
    id: '0',
    name: 'Sole Capsule',
    price: 150,
    colors: [0XFFFFFFFF, 0XFF000000],
    discount: 50,
    description: 'Sole Capsule 1.0 - 1 Box (Black/White)',
    productDetails: '''
Perhaps the most iconic sneaker of all-time, this original "Chicago"? colorway is the cornerstone to any sneaker collection. Made famous in 1985 by Michael Jordan, the shoe has stood the test of time, becoming the most famous colorway of the Air Jordan 1.

- Premium Sneaker Safeguard: Dust and UV protection

- Size-Friendly Design: Accommodates up to US 13

- Elevated Storage Style: Display with confidence''',
    isOutOfStock: false,
    productImages: [
      'https://firebasestorage.googleapis.com/v0/b/sole-capsule.appspot.com/o/WhatsApp%20Image%202024-01-25%20at%2000.57.01.jpeg?alt=media&token=895f2994-aba0-47d5-bbf5-8a9b3f728df0',
      'https://firebasestorage.googleapis.com/v0/b/sole-capsule.appspot.com/o/WhatsApp%20Image%202024-01-25%20at%2000.56.59.jpeg?alt=media&token=4a90517f-822c-477e-8632-1a27d612c619',
      'https://firebasestorage.googleapis.com/v0/b/sole-capsule.appspot.com/o/WhatsApp%20Image%202024-01-25%20at%2000.56.59%20(1).jpeg?alt=media&token=a8763b72-27ea-4da2-89de-d12acdbcdec3',
      'https://firebasestorage.googleapis.com/v0/b/sole-capsule.appspot.com/o/WhatsApp%20Image%202024-01-25%20at%2000.56.58.jpeg?alt=media&token=7b8cc48b-2aeb-46df-9fd9-db302aef1285',
      'https://firebasestorage.googleapis.com/v0/b/sole-capsule.appspot.com/o/WhatsApp%20Image%202024-01-24%20at%2012.00.23.jpeg?alt=media&token=8f09b95c-3aa2-4e36-ae77-64941378e4ed',
    ],
  ),
];
