import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helpers/firebase_constants.dart';
import '../models/discount.dart';

class DiscountProvider with ChangeNotifier {
  Discount? _discount;
  Discount? get discount => _discount;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> getDiscount({
    required String code,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      QuerySnapshot querySnapshot = await FirebaseConstants.cloudInstance
          .collection('discounts')
          .where(
            'code',
            isEqualTo: code,
          )
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> data =
            querySnapshot.docs.first.data() as Map<String, dynamic>;

        Discount newDiscount = Discount.fromJson(data);

        if (newDiscount.validityPeriod
            .toDate()
            .isBefore(Timestamp.now().toDate())) {
          _errorMessage = 'Discount code is expired';
          _discount = null;

          notifyListeners();
        } else {
          _errorMessage = '';
          _discount = newDiscount;

          notifyListeners();
        }
      } else {
        _errorMessage = 'No discount found';
        notifyListeners();
      }

      _isLoading = false;

      notifyListeners();
    } catch (e) {
      print('Get discount error: $e');

      _isLoading = false;
      _discount = null;

      notifyListeners();
    }
  }

  void resetDiscount() {
    _discount = null;
    _errorMessage = '';

    notifyListeners();
  }
}
