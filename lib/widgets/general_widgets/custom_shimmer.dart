import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../provider/theme_mode_provider.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
    this.height,
    this.width,
  });

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeProvider>(builder: (context, tmPvr, child) {
      bool isLightMode = tmPvr.isLight;

      return Shimmer.fromColors(
        baseColor: isLightMode ? Colors.grey.shade100 : Colors.white30,
        highlightColor: isLightMode ? Colors.grey.shade50 : Colors.white12,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      );
    });
  }
}
