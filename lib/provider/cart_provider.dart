import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helpers/firebase_constants.dart';
import '../helpers/get_user_id.dart';
import '../helpers/scaffold_messenger_helper.dart';
import '../main.dart';
import '../models/cart.dart';
import '../models/order.dart';
import '../widgets/general_widgets/loader_widget.dart';

class CartProvider with ChangeNotifier {
  String uid = UserId.getUid();
  final context = MainApp.navigatorKey.currentState?.overlay?.context;

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

  Future<void> getCartItems({
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      _cartItems.clear();
      var cartCollection = FirebaseConstants.cloudInstance
          .collection('users')
          .doc(uid)
          .collection('cart');

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await cartCollection.get();

      List<dynamic> query = querySnapshot.docs;
      QueryDocumentSnapshot docSnap;
      Map<String, dynamic> data = {};

      for (docSnap in query) {
        data = docSnap.data() as Map<String, dynamic>;

        Cart cart = Cart.fromJson(json: data);

        _cartItems.add(cart);
      }

      notifyListeners();
    } catch (e) {
      print(e);
      showScaffoldMessenger(
        scaffoldKey: scaffoldKey,
        textContent: 'Couldn\'t add to cart',
      );
    }
  }

  Future<void> removeFromCart({
    required String cartId,
  }) async {
    try {
      var cartCollection = FirebaseConstants.cloudInstance
          .collection('users')
          .doc(uid)
          .collection('cart');

      await cartCollection.doc(cartId).delete().then((_) {
        _cartItems.removeWhere(
          (c) => c.id == cartId,
        );

        notifyListeners();
      });
    } catch (e) {
      print('Error removing from cart: $e');
    }
  }

  Future<void> emptyCart() async {
    try {
      var cartCollection = FirebaseConstants.cloudInstance
          .collection('users')
          .doc(uid)
          .collection('cart');

      await cartCollection.snapshots().forEach(
            (element) => element.docs.clear(),
          );
    } catch (e) {
      print('Empty cart error: $e');
    }
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

  Future<void> purchaseCartItems({
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      showCustomLoader();

      var ordersCollections = FirebaseConstants.cloudInstance
          .collection('users')
          .doc(uid)
          .collection('orders');

      Cart cart;

      for (cart in _cartItems) {
        Orders order = Orders(
          id: '',
          color: cart.color,
          price: cart.cartProduct().price,
          status: 'Pending',
          prodId: cart.prodId,
          quantity: cart.quantity,
          paymentMethod: 'Cash in',
        );

        await ordersCollections.add(order.toJson()).then((value) async {
          await ordersCollections.doc(value.id).set(
            {
              'id': value.id,
            },
            SetOptions(merge: true),
          );
        }).then((_) {
          _cartItems.clear();

          notifyListeners();

          if (context != null) {
            Navigator.pushNamedAndRemoveUntil(
              context!,
              '/CheckOutSuccessScreen',
              (route) => false,
            );
          }
        });
      }
    } catch (e) {
      print('Purchase cart items error: $e');

      if (context != null) {
        Navigator.pop(context!);
        Navigator.pop(context!);
      }

      showScaffoldMessenger(
        scaffoldKey: scaffoldKey,
        textContent: 'An error occured couldn\'t complete purchase',
      );
    }
  }
}
