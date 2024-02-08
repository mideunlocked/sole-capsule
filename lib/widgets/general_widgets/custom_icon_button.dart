import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'custom_icon.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    this.onTap,
  });

  final String icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFD4D4D4),
          ),
          shape: BoxShape.circle,
        ),
        child: CustomIcon(
          icon: icon,
        ),
      ),
    );
  }
}
