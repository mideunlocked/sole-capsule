import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    super.key,
    required this.icon,
    this.isPlane = true,
  });

  final String icon;
  final bool isPlane;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$icon.svg',
      height: 3.h,
      width: 3.w,
      // ignore: deprecated_member_use
      color: isPlane ? Colors.black : null,
    );
  }
}
