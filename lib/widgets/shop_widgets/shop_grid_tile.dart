import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/product.dart';
import '../general_widgets/product_image.dart';

class ShopGridTile extends StatelessWidget {
  const ShopGridTile({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    var bodyLarge = textTheme.bodyLarge;

    var borderRadius = BorderRadius.circular(20);

    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        '/ProductScreen',
        arguments: product,
      ),
      borderRadius: borderRadius,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: 100.w,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 3.w,
              vertical: 2.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: bodyLarge?.copyWith(fontSize: 15.sp),
                ),
                SizedBox(height: 1.h),
                Text(
                  product.description,
                ),
                SizedBox(height: 1.h),
                Text(
                  '\$${product.price}',
                  style: textTheme.labelMedium?.copyWith(
                    fontSize: 11.sp,
                  ),
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          ProductImage(
            imageUrl: product.productImages.last,
            borderRadius: 20,
          ),
        ],
      ),
    );
  }
}
