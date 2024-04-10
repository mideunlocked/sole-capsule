import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/theme_mode_provider.dart';

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
    return Consumer<ThemeModeProvider>(builder: (context, tmPvr, child) {
      bool isLightMode = tmPvr.isLight;

      return SvgPicture.asset(
        'assets/icons/$icon.svg',
        fit: BoxFit.cover,
        height: 3.h,
        width: 3.w,
        // ignore: deprecated_member_use
        color: isPlane
            ? isLightMode
                ? Colors.black
                : Colors.white
            : null,
      );
    });
  }
}
