import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helpers/firebase_constants.dart';
import '../helpers/get_user_id.dart';
import '../helpers/scaffold_messenger_helper.dart';
import '../main.dart';
import '../models/order.dart';

class OrderProvider with ChangeNotifier {
  String uid = UserId.getUid();
  final context = MainApp.navigatorKey.currentState?.overlay?.context;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<Orders> _orders = [];
  List<Orders> get orders => _orders;

  Future<void> getOrders({
    bool isInitial = false,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    if (isInitial) {
      _isLoading = true;
      notifyListeners();
    }

    try {
      var ordersCollections = FirebaseConstants.cloudInstance
          .collection('users')
          .doc(uid)
          .collection('orders');

      QuerySnapshot querySnapshot = await ordersCollections.get();

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        Orders order = Orders.fromJson(
          json: data,
        );

        bool checkOrder = _orders.any((element) => element.id == order.id);

        if (!checkOrder) {
          _orders.add(order);
        }
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      print('Get orders error: $e');
      showScaffoldMessenger(
        scaffoldKey: scaffoldKey,
        textContent: 'Couldn\'t get orders, Try again',
      );
    }
  }
}
