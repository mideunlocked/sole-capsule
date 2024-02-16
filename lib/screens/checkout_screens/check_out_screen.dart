import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sole_capsule/provider/cart_provider.dart';

import '../../models/delivery_details.dart';
import '../../provider/user_provider.dart';
import '../../widgets/checkout_widgets/order_details_sheet.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/general_widgets/custom_button.dart';
import '../../widgets/general_widgets/custom_icon.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';
import '../../widgets/shopping_cart_widgets/shopping_cart_widget.dart';

class CheckOutScreen extends StatelessWidget {
  static const routeName = '/CheckOutScreen';

  const CheckOutScreen({super.key});

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
      body: SafeArea(
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
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 3.h),
                          child: Consumer<UserProvider>(
                              builder: (context, userPvr, _) {
                            DeliveryDetails details =
                                userPvr.user.deliveryDetails;

                            String shortAddress =
                                '${details.address}, ${details.state}, ${details.country}';

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 60.w,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Address:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      Text(
                                        shortAddress,
                                        maxLines: 1,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text('Contact : ${details.number}'),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => Navigator.pushNamed(
                                    context,
                                    '/CheckOutDetailsScreen',
                                  ),
                                  icon: const CustomIcon(icon: 'edit'),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
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
                      : () => showOrderDetailsSheet(context: context),
                );
              }),
              sizedBox,
            ],
          ),
        ),
      ),
    );
  }
}
