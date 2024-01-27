import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/app_colors.dart';

class OnboardingIndicator extends StatelessWidget {
  const OnboardingIndicator({
    super.key,
    required this.isCurrent,
  });

  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5.h,
      width: 12.w,
      margin: EdgeInsets.only(right: 1.w),
      decoration: BoxDecoration(
        color: isCurrent ? AppColors.primary : const Color(0xFFE3E3E3),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
