import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ImageIndicator extends StatelessWidget {
  const ImageIndicator({
    super.key,
    required this.isCurrent,
  });

  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.5.w),
      child: Icon(
        Icons.circle_rounded,
        color: isCurrent ? Colors.black : Colors.grey,
        size: isCurrent ? 10.sp : 6.sp,
      ),
    );
  }
}
