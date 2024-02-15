import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/product.dart';
import 'product_image_view_handler.dart';

class ProdImageTile extends StatelessWidget {
  const ProdImageTile({
    super.key,
    required this.image,
    required this.pgCtr,
    required this.prod,
    required this.index,
  });

  final String image;
  final PageController pgCtr;
  final Product prod;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              image,
              fit: BoxFit.cover,
              height: 28.h,
              width: 100.w,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProdImageViewHandler(
                  icon: Icons.arrow_circle_left_rounded,
                  onTap: () {
                    pgCtr.previousPage(
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeOut,
                    );
                  },
                  visible: index != 0,
                ),
                ProdImageViewHandler(
                  icon: Icons.arrow_circle_right_rounded,
                  onTap: () {
                    pgCtr.nextPage(
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeIn,
                    );
                  },
                  visible: index != prod.productImages.length - 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
