import 'package:flutter/material.dart';

import '../helpers/scaffold_messenger_helper.dart';
import '../models/cart.dart';

class CartProvider with ChangeNotifier {
  final List<Cart> _cartItems = [];
  List<Cart> get cartItems => _cartItems;

  double _totalCartPrice = 0;
  double get totalCartPrice => _totalCartPrice;

  void addToCart({
    required Cart cart,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) {
    _cartItems.add(cart);

    showScaffoldMessenger(
      scaffoldKey: scaffoldKey,
      textContent: 'Added to cart',
      bkgColor: Colors.green,
    );

    notifyListeners();
  }

  void removeFromCart({
    required String cartId,
  }) {
    _cartItems.removeWhere(
      (c) => c.id == cartId,
    );

    notifyListeners();
  }

  bool alreadyInCart({
    required String prodId,
  }) {
    return _cartItems.any((c) => c.prodId == prodId);
  }

  void notifyAlreadyInCart({
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) {
    showScaffoldMessenger(
      scaffoldKey: scaffoldKey,
      textContent: 'Already added in cart',
      bkgColor: Colors.grey,
    );
  }

  void calculateCartTotalPrice() {
    double total = 0;

    Cart cart;

    for (cart in _cartItems) {
      total = total + cart.totalCartPrice();
    }

    _totalCartPrice = total;
  }
}
