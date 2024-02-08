import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 60.w,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Address:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    const Text(
                                      '216 St Paul\'s Rd, London N1 2LL, UK',
                                      maxLines: 1,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Text('Contact : +44-784232'),
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
                          ),
                        ),
                      ),
                      sizedBox,
                      const ShoppingCartWidget(),
                    ],
                  ),
                ),
              ),
              sizedBox2,
              CustomButton(
                label: 'Checkout',
                onTap: () {},
              ),
              sizedBox,
            ],
          ),
        ),
      ),
    );
  }
}
