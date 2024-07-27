import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/theme_mode_provider.dart';

class SoleAppIcon extends StatelessWidget {
  const SoleAppIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var themePvr = Provider.of<ThemeModeProvider>(context, listen: false);

    bool isLight = themePvr.isLight;

    return Image.asset(
      'assets/logo/SOLE CAPSULE.png',
      height: 6.h,
      width: 12.w,
      color: isLight ? null : Colors.white,
    );
  }
}
