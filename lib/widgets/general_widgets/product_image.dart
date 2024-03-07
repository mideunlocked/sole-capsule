import 'package:flutter/material.dart';

import 'sole_image_loader.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.imageUrl,
    this.borderRadius = 15,
    this.height,
    this.width,
  });

  final double borderRadius;
  final String imageUrl;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        imageUrl,
        height: height,
        width: width,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            height: height,
            width: width,
            child: const SoleImageLoader(),
          );
        },
        errorBuilder: (ctx, _, stacktrace) {
          return SizedBox(
            height: height,
            width: width,
            child: Center(
              child: Image.asset(
                'assets/logo/SOLE CAPSULE.png',
                color: Colors.grey.shade300,
              ),
            ),
          );
        },
      ),
    );
  }
}
