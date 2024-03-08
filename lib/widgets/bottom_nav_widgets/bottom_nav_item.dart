// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/theme_mode_provider.dart';

class BottomNavItem extends StatelessWidget {
  const BottomNavItem({
    super.key,
    required this.label,
    required this.icon,
    required this.currentIndex,
    required this.index,
    required this.function,
  });

  final String label;
  final String icon;
  final int index;
  final int currentIndex;
  final Function(int) function;

  @override
  Widget build(BuildContext context) {
    bool isCurrent = currentIndex == index;

    Color lightColor = isCurrent ? Colors.black : const Color(0xFF6A6A6A);
    Color darkColor = isCurrent ? Colors.white : Colors.white54;

    return InkWell(
      onTap: () => function(index),
      child: Consumer<ThemeModeProvider>(builder: (context, tmPvr, child) {
        bool isLightMode = tmPvr.isLight;

        return Row(
          children: [
            SvgPicture.asset(
              'assets/icons/$icon',
              color: isLightMode ? lightColor : darkColor,
              height: 3.h,
              width: 3.w,
            ),
            SizedBox(width: 3.w),
            Text(
              label,
              style: TextStyle(
                color: isLightMode ? lightColor : darkColor,
                fontSize: 9.sp,
              ),
            ),
          ],
        );
      }),
    );
  }
}
