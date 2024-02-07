import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sole_capsule/widgets/general_widgets/custom_app_bar.dart';

import '../../widgets/general_widgets/custom_button.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';
import '../../widgets/shopping_cart_widgets/shopping_cart_widget.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/CartScreen';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 3.h);

    return Scaffold(
      body: SafeArea(
        child: PaddedScreenWidget(
          child: Column(
            children: [
              const CustomAppBar(
                title: 'Cart',
              ),
              sizedBox,
              const Expanded(
                child: ShoppingCartWidget(),
              ),
              SizedBox(height: 1.5.h),
              CustomButton(
                label: 'Checkout',
                onTap: () => Navigator.pushNamed(
                  context,
                  '/CheckOutScreen',
                ),
              ),
              sizedBox,
            ],
          ),
        ),
      ),
    );
  }
}
