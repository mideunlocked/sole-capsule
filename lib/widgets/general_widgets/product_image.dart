import 'package:flutter/material.dart';

import 'custom_progress_inidicator.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
  });

  final String imageUrl;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
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
            child: const Center(
              child: CustomProgressIndicator(),
            ),
          );
        },
        errorBuilder: (ctx, _, stacktrace) {
          return SizedBox(
            height: height,
            width: width,
            child: const Center(
              child: Icon(
                Icons.error_rounded,
                color: Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }
}
