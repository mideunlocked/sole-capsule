import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/checkout_widgets/delivery_preview_card.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/general_widgets/custom_icon.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';

class OrderDetailsScreen extends StatelessWidget {
  static const routeName = '/OrderDetailsScreen';

  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var customTextStyle = textTheme.bodyMedium?.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
    );

    var sizedBox2 = SizedBox(height: 1.5.h);

    return Scaffold(
      body: Column(
        children: [
          PaddedScreenWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(
                  title: '',
                ),
                SizedBox(height: 3.h),
                Row(
                  children: [
                    const CustomIcon(icon: 'pin'),
                    SizedBox(width: 1.w),
                    Text(
                      'Delivery Address',
                      style: customTextStyle,
                    ),
                  ],
                ),
                sizedBox2,
                const DeliveryPreviewCard(),
                SizedBox(height: 5.h),
                // Shoppin
              ],
            ),
          ),
        ],
      ),
    );
  }
}
