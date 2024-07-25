// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/calculate_discount.dart';
import '../helpers/firebase_constants.dart';
import '../helpers/get_user_id.dart';
import '../helpers/scaffold_messenger_helper.dart';
import '../services/stripe_payment.dart';
import '../models/cart.dart';
import '../models/order.dart';
import '../models/users.dart';
import '../widgets/general_widgets/loader_widget.dart';
import 'user_provider.dart';

class CartProvider with ChangeNotifier {
  final List<Cart> _cartItems = [];
  List<Cart> get cartItems => _cartItems;

  Cart _directCart = Cart.nullCart();
  Cart get directCart => _directCart;

  double _totalCartPrice = 0;
  double get totalCartPrice => _totalCartPrice;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Users getUser(BuildContext context) {
    var userPvr = Provider.of<UserProvider>(context, listen: false);

    return userPvr.user;
  }

  Future<void> addToCart({
    required Cart cart,
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    String uid = UserId.getUid();

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
            context: context,
          );
        });
      }).catchError((_) {
        _isLoading = false;
        notifyListeners();

        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent: 'Couldn\'t add to cart',
          context: context,
        );
      });

      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      showScaffoldMessenger(
        scaffoldKey: scaffoldKey,
        textContent: 'Couldn\'t add to cart',
        context: context,
      );
    }
  }

  Future<void> getCartItems({
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    String uid = UserId.getUid();

    try {
      _cartItems.clear();
      var cartCollection = FirebaseConstants.cloudInstance
          .collection('users')
          .doc(uid)
          .collection('cart');

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await cartCollection.orderBy('timestamp', descending: true).get();

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
      showScaffoldMessenger(
        scaffoldKey: scaffoldKey,
        textContent: 'Couldn\'t get cart items',
        context: context,
      );
    }
  }

  Future<void> removeFromCart({
    required String cartId,
  }) async {
    String uid = UserId.getUid();

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
    String uid = UserId.getUid();

    try {
      var cartCollection = FirebaseConstants.cloudInstance
          .collection('users')
          .doc(uid)
          .collection('cart');

      await cartCollection.snapshots().forEach(
            (element) => element.docs.clear(),
          );
    } catch (e) {
      print('Error emptying cart: $e');
    }
  }

  bool alreadyInCart({
    required String prodId,
  }) {
    return _cartItems.any((c) => c.prodId == prodId);
  }

  void notifyAlreadyInCart({
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) {
    showScaffoldMessenger(
      scaffoldKey: scaffoldKey,
      textContent: 'Already added in cart',
      bkgColor: Colors.grey,
      context: context,
    );
  }

  void calculateCartTotalPrice(BuildContext context) {
    double total = 0;

    Cart cart;

    for (cart in _cartItems) {
      total = total + cart.totalCartPrice(context);
    }

    _totalCartPrice = total;
  }

  Future<void> purchaseDirectCart({
    required String paymentMethod,
    required String currency,
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    String uid = UserId.getUid();

    try {
      _isLoading = true;
      notifyListeners();

      var ordersCollections = FirebaseConstants.cloudInstance
          .collection('users')
          .doc(uid)
          .collection('orders');

      double orderPrice = double.parse(
        CalculateDiscount.calculateDiscount(
          _directCart.cartProduct(context).price,
          _directCart.cartProduct(context).discount ?? 0,
        ),
      );

      double orderAmount = orderPrice * _directCart.quantity;

      bool isPaid = await StripePayment.initializePayment(
        scaffoldKey: scaffoldKey,
        deliveryDetails: getUser(context).deliveryDetails,
        currency: currency,
        amount: orderAmount.toInt(),
        context: context,
      );

      _isLoading = false;
      notifyListeners();

      if (context.mounted) showCustomLoader(context);

      if (isPaid) {
        if (context.mounted) {
          Orders order = Orders(
            id: '',
            color: _directCart.color,
            price: orderAmount,
            status: 'Pending',
            prodId: _directCart.prodId,
            quantity: _directCart.quantity,
            timestamp: Timestamp.now(),
            paymentMethod: paymentMethod,
            deliveryDetails: getUser(context).deliveryDetails,
            product: null,
          );

          await ordersCollections.add(order.toJson()).then((value) async {
            await ordersCollections.doc(value.id).set(
              {
                'id': value.id,
              },
              SetOptions(merge: true),
            );
          });

          removeDirectCart();

          _isLoading = false;

          notifyListeners();

          if (context.mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/CheckOutSuccessScreen',
              (route) => false,
            );
          }
        }
      } else {
        _isLoading = false;
        notifyListeners();

        if (context.mounted) {
          Navigator.pop(context);
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        Navigator.pop(context);
      }

      showScaffoldMessenger(
        scaffoldKey: scaffoldKey,
        textContent: 'An error occured couldn\'t complete purchase',
        context: context,
      );
    }
  }

  Future<void> purchaseCartItems({
    required String currency,
    required String paymentMethod,
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    String uid = UserId.getUid();
    try {
      _isLoading = true;
      notifyListeners();

      bool isPaid = await StripePayment.initializePayment(
        scaffoldKey: scaffoldKey,
        deliveryDetails: getUser(context).deliveryDetails,
        currency: currency,
        amount: _totalCartPrice.toInt(),
        context: context,
      );

      _isLoading = false;
      notifyListeners();

      if (isPaid) {
        if (context.mounted) showCustomLoader(context);

        var ordersCollections = FirebaseConstants.cloudInstance
            .collection('users')
            .doc(uid)
            .collection('orders');

        Cart cart;

        for (cart in _cartItems) {
          double orderPrice = double.parse(
            CalculateDiscount.calculateDiscount(
              cart.cartProduct(context).price,
              cart.cartProduct(context).discount ?? 0,
            ),
          );

          Orders order = Orders(
            id: '',
            color: cart.color,
            price: orderPrice,
            status: 'Pending',
            prodId: cart.prodId,
            quantity: cart.quantity,
            timestamp: Timestamp.now(),
            paymentMethod: paymentMethod,
            deliveryDetails: getUser(context).deliveryDetails,
            product: null,
          );

          await ordersCollections.add(order.toJson()).then((value) async {
            await ordersCollections.doc(value.id).set(
              {
                'id': value.id,
              },
              SetOptions(merge: true),
            );
          });
        }

        _cartItems.clear();

        await deleteCollection();

        notifyListeners();

        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/CheckOutSuccessScreen',
            (route) => false,
          );
        }
      } else {
        _isLoading = false;
        notifyListeners();

        if (context.mounted) {
          Navigator.pop(context);
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        Navigator.pop(context);
      }

      showScaffoldMessenger(
        scaffoldKey: scaffoldKey,
        textContent: 'An error occured couldn\'t complete purchase',
        context: context,
      );
    }
  }

  Future<void> deleteCollection() async {
    String uid = UserId.getUid();

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot querySnapshot =
        await firestore.collection('users/$uid/cart').get();

    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      await documentSnapshot.reference.delete();
    }
  }

  Future<void> deleteCartItem({
    required String id,
  }) async {
    try {
      String uid = UserId.getUid();

      _cartItems.removeWhere((element) => element.id == id);

      notifyListeners();

      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      await firestore.collection('users/$uid/cart').doc(id).delete();
    } catch (e) {
      print('Error deleting cart item: $e');
    }
  }

  void putDirectCart({
    required Cart cart,
  }) {
    _directCart = cart;
  }

  void removeDirectCart() {
    _directCart = Cart.nullCart();

    notifyListeners();
  }

  void updateCartQuantity({
    required String id,
    required int quantity,
  }) {
    Cart cart = _cartItems.firstWhere((e) => e.id == id);
    int index = _cartItems.indexOf(cart);

    cart = Cart(
      id: id,
      color: cart.color,
      prodId: cart.prodId,
      quantity: quantity,
    );

    _cartItems.setAll(index, [cart]);

    notifyListeners();
  }
}
