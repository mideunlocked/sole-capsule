import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PaddedScreenWidget extends StatelessWidget {
  const PaddedScreenWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    double horizontal = 5.w;

    return Padding(

      padding: EdgeInsets.only(
        left: horizontal,
        right: horizontal,
        top: 4.h,
      ),
      child: child,
    );
  }
}
