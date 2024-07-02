import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../main.dart';
import 'custom_progress_inidicator.dart';

void showCustomLoader() {
  final context = MainApp.navigatorKey.currentState?.overlay?.context;

  if (context != null) {
    showDialog(
      context: context,
      builder: (ctx) => const LoaderWidget(),
    );
  }
}

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) async {
        Navigator.pop(context);
        throw 0;
      },
      child: Dialog(
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 39.w, vertical: 43.h),
        child: const Center(
          child: CustomProgressIndicator(),
        ),
      ),
    );
  }
}
