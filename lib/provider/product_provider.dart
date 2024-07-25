// ignore_for_file: avoid_print

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

  Future<Product?> getProduct({
    required String prodId,
  }) async {
    try {
      DocumentSnapshot response = await FirebaseConstants.cloudInstance
          .collection(productsPath)
          .doc(prodId)
          .get();

      if (response.exists) {
        Map<String, dynamic> data = response.data() as Map<String, dynamic>;

        Product product = Product.fromJSon(json: data);

        return product;
      } else {
        return null;
      }
    } catch (e) {
      print('Couldn\'t get product error: $e');
      return null;
    }
  }

  Future<void> getProducts({
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseConstants.cloudInstance
              .collection(productsPath)
              .orderBy('timestamp')
              .get();

      List<dynamic> query = querySnapshot.docs;
      QueryDocumentSnapshot docSnap;
      Map<String, dynamic> data = {};

      for (docSnap in query) {
        data = docSnap.data() as Map<String, dynamic>;

        Product product = Product.fromJSon(json: data);

        bool isIn = _products.any((p) => p.id == product.id);

        if (!isIn) {
          _products.add(product);
        }
      }

      getProductCount();

      notifyListeners();
    } catch (e) {
      print('Get product error: $e');
      showScaffoldMessenger(
        context: context,
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
