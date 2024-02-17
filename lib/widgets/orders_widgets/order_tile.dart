import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/cart.dart';
import '../../models/product.dart';
import '../general_widgets/product_image.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 1.5.h);

    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var customTextStyle = textTheme.bodyMedium?.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
    );

    Product prod = cart.cartProduct();

    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        '/ProductScreen',
        arguments: prod,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImage(
              imageUrl: prod.productImages.last,
              height: 20.h,
              width: 35.w,
            ),
            SizedBox(width: 5.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBox,
                Text(
                  prod.name,
                  style: customTextStyle,
                ),
                SizedBox(height: 1.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                    vertical: 1.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    '\$ ${cart.totalCartPrice()}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
