import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PaddedScreenWidget extends StatelessWidget {
  const PaddedScreenWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 0,
      ),
      child: child,
    );
  }
}
