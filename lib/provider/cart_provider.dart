import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helpers/firebase_constants.dart';
import '../helpers/scaffold_messenger_helper.dart';
import '../models/cart.dart';

class CartProvider with ChangeNotifier {
  String uid = FirebaseConstants.authInstance.currentUser?.uid ?? '';

  final List<Cart> _cartItems = [];
  List<Cart> get cartItems => _cartItems;

  double _totalCartPrice = 0;
  double get totalCartPrice => _totalCartPrice;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> addToCart({
    required Cart cart,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      _isLoading = true;

      notifyListeners();

      var cartCollection = FirebaseConstants.cloudInstance
          .collection('users')
          .doc(uid)
          .collection('cart');

      await cartCollection
          .add(cart.toJson(
        id: '',
        cart: cart,
      ))
          .then((value) async {
        String docId = value.id;

        await cartCollection.doc(docId).set(
          {
            'id': docId,
          },
          SetOptions(merge: true),
        ).then((value) {
          _cartItems.add(cart);
          _isLoading = false;

          notifyListeners();
          showScaffoldMessenger(
            scaffoldKey: scaffoldKey,
            textContent: 'Added to cart',
            bkgColor: Colors.green,
          );
        });
      }).catchError((_) {
        _isLoading = false;
        notifyListeners();

        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent: 'Couldn\'t add to cart',
        );
      });

      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      print(e);
      showScaffoldMessenger(
        scaffoldKey: scaffoldKey,
        textContent: 'Couldn\'t add to cart',
      );
    }
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