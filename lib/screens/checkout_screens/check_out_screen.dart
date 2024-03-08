import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/cart_provider.dart';
import '../../widgets/checkout_widgets/delivery_preview_card.dart';
import '../../widgets/checkout_widgets/order_details_sheet.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/general_widgets/custom_button.dart';
import '../../widgets/general_widgets/custom_icon.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';
import '../../widgets/shopping_cart_widgets/shopping_cart_widget.dart';

class CheckOutScreen extends StatefulWidget {
  static const routeName = '/CheckOutScreen';

  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var customTextStyle = textTheme.bodyMedium?.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
    );

    var sizedBox = SizedBox(height: 3.h);
    var sizedBox2 = SizedBox(height: 1.5.h);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScaffoldMessenger(
        key: _scaffoldKey,
        child: SafeArea(
          child: PaddedScreenWidget(
            child: Column(
              children: [
                const CustomAppBar(
                  title: 'Checkout',
                ),
                sizedBox,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CustomIcon(
                              icon: 'pin',
                            ),
                            SizedBox(width: 3.w),
                            Text(
                              'Delivery Address',
                              style: customTextStyle,
                            ),
                          ],
                        ),
                        sizedBox2,
                        const DeliveryPreviewCard(),
                        sizedBox,
                        const ShoppingCartWidget(),
                      ],
                    ),
                  ),
                ),
                sizedBox2,
                Consumer<CartProvider>(builder: (context, cartPvr, _) {
                  return CustomButton(
                    label: 'Checkout',
                    onTap: cartPvr.cartItems.isEmpty
                        ? null
                        : () => showOrderDetailsSheet(
                              context: context,
                              scaffoldKey: _scaffoldKey,
                            ),
                  );
                }),
                sizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
