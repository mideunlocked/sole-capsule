// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sole_capsule/helpers/scaffold_messenger_helper.dart';

import '../helpers/firebase_constants.dart';
import '../models/notification.dart';

class NotificationProvider with ChangeNotifier {
  final List<Notifications> _notifications = [];
  List<Notifications> get notifications => _notifications;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void loading() {
    _isLoading = true;

    notifyListeners();
  }

  void loaded() {
    _isLoading = false;

    notifyListeners();
  }

  Future<void> getNotifications({
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      loading();

      _notifications.clear();

      QuerySnapshot querySnapshot = await FirebaseConstants.cloudInstance
          .collection('notifications')
          .orderBy('timestamp', descending: true)
          .get();

      List<QueryDocumentSnapshot> docs = querySnapshot.docs;

      if (docs.isNotEmpty) {
        for (QueryDocumentSnapshot d in docs) {
          Map<String, dynamic> data = d.data() as Map<String, dynamic>;

          Notifications notification = Notifications.fromJson(json: data);

          _notifications.add(notification);
        }

        loaded();
        notifyListeners();
      } else {
        if (context.mounted) {
          showScaffoldMessenger(
            scaffoldKey: scaffoldKey,
            context: context,
            textContent: 'Error fetching notifications',
          );
        }
        loaded();
      }
    } catch (e) {
      print('Get notification error: $e');
      if (context.mounted) {
        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent: 'Error fetching notifications',
          context: context,
        );
      }
      loaded();
    }
  }
}
