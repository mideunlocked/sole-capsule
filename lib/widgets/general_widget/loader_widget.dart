import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void showCustomLoader({required BuildContext context}) {
  showDialog(
    context: context,
    builder: (ctx) => const LoaderWidget(),
  );
}

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 39.w, vertical: 43.h),
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
          backgroundColor: Colors.black38,
          strokeWidth: 4,
        ),
      ),
    );
  }
}
