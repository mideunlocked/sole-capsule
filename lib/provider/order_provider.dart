// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/firebase_constants.dart';
import '../helpers/get_user_id.dart';
import '../helpers/scaffold_messenger_helper.dart';
import '../models/order.dart';
import '../models/product.dart';
import 'product_provider.dart';

class OrderProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<Orders> _orders = [];
  List<Orders> get orders => _orders;

  Future<void> getOrders({
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    String uid = UserId.getUid();

    _isLoading = true;
    notifyListeners();

    try {
      var ordersCollections = FirebaseConstants.cloudInstance
          .collection('users')
          .doc(uid)
          .collection('orders');

      QuerySnapshot querySnapshot = await ordersCollections.get();

      ProductProvider productPvr;

      if (context.mounted) {
        productPvr = Provider.of<ProductProvider>(
          context,
          listen: false,
        );

        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data =
              documentSnapshot.data() as Map<String, dynamic>;

          Product? product = await productPvr.getProduct(
            prodId: data['prodId'].toString(),
          );

          Orders order = Orders.fromJson(
            json: data,
            product: product,
          );

          bool checkOrder = _orders.any((element) => element.id == order.id);

          if (!checkOrder) {
            _orders.add(order);
          }
        }

        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      print('Get orders error: $e');
      if (context.mounted) {
        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          context: context,
          textContent: 'Couldn\'t get orders, Try again',
        );
      }
    }
  }
}
