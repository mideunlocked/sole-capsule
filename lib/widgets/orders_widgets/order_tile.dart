import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/cart.dart';
import '../../models/product.dart';
import '../../provider/cart_provider.dart';
import '../../provider/theme_mode_provider.dart';
import '../general_widgets/product_image.dart';

class OrderTile extends StatefulWidget {
  const OrderTile({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  int quantity = 1;

  @override
  void initState() {
    super.initState();

    quantity = widget.cart.quantity;
  }

  void increaseQuantity() {
    setState(() => quantity++);

    updateQuantity();
  }

  void decreaseQuantity() {
    setState(() => quantity > 1 ? quantity-- : null);

    updateQuantity();
  }

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 1.5.h);

    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var customTextStyle = textTheme.bodyMedium?.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
    );

    Product prod = widget.cart.cartProduct();

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
                    Consumer<CartProvider>(
                      builder: (context, cartPvr, child) {
                        return IconButton(
                          onPressed: () async => cartPvr.deleteCartItem(
                            id: widget.cart.id,
                          ),
                          icon: child!,
                        );
                      },
                      child: const Icon(
                        Icons.delete_rounded,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              sizedBox,
              Consumer<ThemeModeProvider>(
                builder: (context, tmPvr, child) {
                  bool isLightMode = tmPvr.isLight;

                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 1.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isLightMode ? Colors.black12 : Colors.white12,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: child!,
                  );
                },
                child: Text(
                  '\$ ${widget.cart.totalCartPrice()}',
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
                    QuantityButton(
                      icon: Icons.remove_rounded,
                      onTap: () => decreaseQuantity(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Text(widget.cart.quantity.toString()),
                    ),
                    QuantityButton(
                      icon: Icons.add_rounded,
                      onTap: () => increaseQuantity(),
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

  void updateQuantity() {
    var cartPvr = Provider.of<CartProvider>(context, listen: false);

    cartPvr.updateCartQuantity(
      id: widget.cart.id,
      quantity: quantity,
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
