import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PaddedScreenWidget extends StatelessWidget {
  const PaddedScreenWidget({
    super.key,
    required this.child,
    this.padTop = true,
  });

  final Widget child;
  final bool padTop;

  @override
  Widget build(BuildContext context) {
    double horizontal = 5.w;

    return Padding(
      padding: EdgeInsets.only(
        left: horizontal,
        right: horizontal,
        top: padTop == true ? 4.h : 0,
      ),
      child: child,
    );
  }
}
