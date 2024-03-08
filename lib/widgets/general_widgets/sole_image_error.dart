import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_mode_provider.dart';

class SoleImageError extends StatelessWidget {
  const SoleImageError({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<ThemeModeProvider>(builder: (context, tmPvr, child) {
        bool isLightMode = tmPvr.isLight;

        return Image.asset(
          'assets/logo/SOLE CAPSULE.png',
          color: isLightMode ? Colors.grey.shade300 : Colors.white38,
        );
      }),
    );
  }
}
