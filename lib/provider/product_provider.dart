import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helpers/firebase_constants.dart';
import '../helpers/scaffold_messenger_helper.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  String productsPath = FirebaseConstants.productsPath;

  final List<Product> _products = [];

  List<Product> get products => _products;

  int _productCount = 0;

  int get productCount => _productCount;

  Future<void> getProducts({
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      _products.clear();
      _productCount = 0;
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseConstants.cloudInstance.collection(productsPath).get();

      List<dynamic> query = querySnapshot.docs;
      QueryDocumentSnapshot docSnap;
      Map<String, dynamic> data = {};

      for (docSnap in query) {
        data = docSnap.data() as Map<String, dynamic>;

        Product product = Product.fromJSon(json: data);

        _products.add(product);
      }

      getProductCount();

      notifyListeners();
    } catch (e) {
      print('Get product error: $e');
      showScaffoldMessenger(
        scaffoldKey: scaffoldKey,
        textContent: 'Couldn\'t get products, try again',
      );
    }
  }

  void getProductCount() {
    _productCount = _products.length;

    notifyListeners();
  }
}
