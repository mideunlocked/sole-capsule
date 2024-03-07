import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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

    _animation = ColorTween(
      begin: Colors.grey.shade300,
      end: Colors.grey.shade100,
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
