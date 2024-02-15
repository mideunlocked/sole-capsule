import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/cart_provider.dart';
import '../orders_widgets/order_tile.dart';

class ShoppingCartWidget extends StatelessWidget {
  const ShoppingCartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 1.5.h);

    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var customTextStyle = textTheme.bodyMedium?.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Shopping List',
          style: customTextStyle,
        ),
        sizedBox,
        Consumer<CartProvider>(
          builder: (
            context,
            cartPvr,
            child,
          ) {
            cartPvr.calculateCartTotalPrice();

            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
                child: Column(
                  children: [
                    Column(
                      children: cartPvr.cartItems.map((cart) {
                        return OrderTile(
                          cart: cart,
                        );
                      }).toList(),
                    ),
                    sizedBox,
                    child!,
                    sizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Order (${cartPvr.cartItems.length}) :'),
                        Text(
                          '\$${cartPvr.totalCartPrice}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          child: const Divider(),
        ),
      ],
    );
  }
}
