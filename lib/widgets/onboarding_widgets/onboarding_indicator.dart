import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OnboardingIndicator extends StatelessWidget {
  const OnboardingIndicator({
    super.key,
    required this.index,
    required this.currentIndex,
  });

  final int index;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    bool isCurrent = index == currentIndex;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.5.w),
      child: Icon(
        Icons.circle_rounded,
        color: index == 0 && isCurrent
            ? isCurrent
                ? Colors.white
                : Colors.white60
            : isCurrent
                ? Colors.black
                : Colors.black38,
        size: 10.sp,
      ),
    );
  }
}
