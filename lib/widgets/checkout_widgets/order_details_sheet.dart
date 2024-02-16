import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/cart_provider.dart';
import '../general_widgets/custom_button.dart';
import '../general_widgets/custom_icon_button.dart';
import '../general_widgets/padded_screen_widget.dart';
import 'discount_text_field.dart';
import 'order_details_tile.dart';

void showOrderDetailsSheet({
  required BuildContext context,
}) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    backgroundColor: Colors.white,
    isScrollControlled: true,
    builder: (ctx) => const OrderDetailsSheet(),
  );
}

class OrderDetailsSheet extends StatefulWidget {
  const OrderDetailsSheet({
    super.key,
  });

  @override
  State<OrderDetailsSheet> createState() => _OrderDetailsSheetState();
}

class _OrderDetailsSheetState extends State<OrderDetailsSheet> {
  final discountCodeCtr = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    discountCodeCtr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: PaddedScreenWidget(
        child: Consumer<CartProvider>(builder: (context, cartPvr, _) {
          cartPvr.calculateCartTotalPrice();

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order Payment Details',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  CustomIconButton(
                    icon: 'close',
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              OrderDetailsTile(
                title: 'Order Amounts',
                value: '\$${cartPvr.totalCartPrice}',
              ),
              const OrderDetailsTile(
                title: 'Delivery Fee',
                value: 'Free',
              ),
              SizedBox(height: 2.h),
              DiscountTextField(controller: discountCodeCtr),
              SizedBox(height: 5.h),
              CustomButton(
                onTap: () => Navigator.pushNamed(
                  context,
                  '/CheckOutSuccessScreen',
                ),
                label: 'Proceed to payment',
              ),
              SizedBox(height: 2.h),
            ],
          );
        }),
      ),
    );
  }
}
