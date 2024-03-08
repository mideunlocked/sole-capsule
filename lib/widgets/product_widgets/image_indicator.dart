import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/theme_mode_provider.dart';

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
      child: Consumer<ThemeModeProvider>(builder: (context, tmPvr, child) {
        bool isLightMode = tmPvr.isLight;

        return Icon(
          Icons.circle_rounded,
          color: isCurrent
              ? isLightMode
                  ? Colors.black
                  : Colors.white
              : Colors.grey,
          size: isCurrent ? 10.sp : 6.sp,
        );
      }),
    );
  }
}
