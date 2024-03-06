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

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              '/ProductScreen',
              arguments: prod,
            ),
            child: ProductImage(
              imageUrl: prod.productImages.last,
              height: 25.h,
              width: 35.w,
            ),
          ),
          SizedBox(width: 5.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBox,
              SizedBox(
                width: 40.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/ProductScreen',
                        arguments: prod,
                      ),
                      child: Text(
                        prod.name,
                        style: customTextStyle,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete_rounded,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              sizedBox,
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
              sizedBox,
              Text(
                'Color: White',
                style: customTextStyle,
              ),
              sizedBox,
              SizedBox(
                width: 38.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const QuantityButton(
                      icon: Icons.remove_rounded,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Text(cart.quantity.toString()),
                    ),
                    const QuantityButton(
                      icon: Icons.add_rounded,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class QuantityButton extends StatelessWidget {
  const QuantityButton({
    super.key,
    required this.icon,
    this.onTap,
  });

  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadiusDirectional.circular(8),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 1.w,
          vertical: 0.5.h,
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
