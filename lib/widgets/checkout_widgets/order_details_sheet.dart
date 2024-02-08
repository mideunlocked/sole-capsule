import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../general_widgets/custom_button.dart';
import '../general_widgets/custom_icon_button.dart';
import '../general_widgets/padded_screen_widget.dart';
import 'order_details_tile.dart';

void showOrderDetailsSheet({
  required BuildContext context,
}) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    backgroundColor: Colors.transparent,
    builder: (ctx) => const OrderDetailsSheet(),
  );
}

class OrderDetailsSheet extends StatelessWidget {
  const OrderDetailsSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      width: 100.w,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      child: PaddedScreenWidget(
        child: Column(
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
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: 2.h),
            const OrderDetailsTile(
              title: 'Order Amounts',
              value: '\$7,000.00',
            ),
            const OrderDetailsTile(
              title: 'Delivery Fee',
              value: 'Free',
            ),
            const Spacer(),
            CustomButton(
              onTap: () => Navigator.pushNamed(
                context,
                '/CheckOutSuccessScreen',
              ),
              label: 'Proceed to payment',
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}
