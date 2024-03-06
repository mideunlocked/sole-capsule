import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../main.dart';

void showScaffoldMessenger({
  required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  required String textContent,
  Color bkgColor = Colors.red,
  SnackBarAction? snackBarAction,
}) {
  final context = MainApp.navigatorKey.currentState!.overlay!.context;
  final scaffoldMessenger = ScaffoldMessenger.of(context);

  scaffoldMessenger.showSnackBar(
    SnackBar(
      content: Text(textContent),
      backgroundColor: bkgColor,
      duration: const Duration(seconds: 5),
      margin: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 2.h,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      action: snackBarAction,
    ),
  );
}
