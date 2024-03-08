import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/theme_mode_provider.dart';

class SoleImageLoader extends StatefulWidget {
  const SoleImageLoader({
    super.key,
  });

  @override
  State<SoleImageLoader> createState() => _SoleImageLoaderState();
}

class _SoleImageLoaderState extends State<SoleImageLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // Repeat the animation indefinitely

    var tmPvr = Provider.of<ThemeModeProvider>(context, listen: false);

    bool isLightMode = tmPvr.isLight;

    _animation = ColorTween(
      begin: isLightMode ? Colors.grey.shade300 : Colors.white30,
      end: isLightMode ? Colors.grey.shade100 : Colors.white12,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 2.w,
        ),
        child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Image.asset(
                'assets/logo/SOLE CAPSULE.png',
                color: _animation.value,
              );
            }),
      ),
    );
  }
}
