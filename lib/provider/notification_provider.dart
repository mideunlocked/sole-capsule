import 'package:flutter/material.dart';

import '../models/notification.dart';

class NotificationProvider with ChangeNotifier {
  List<Notifications> _notifications = [];

  List<Notifications> get notifications => _notifications;

  Future<void> getNotifications() async {}
}
