import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/general_widgets/custom_button.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';

class CheckOutSuccessScreen extends StatelessWidget {
  static const routeName = '/CheckOutSuccessScreen';

  const CheckOutSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyLarge = textTheme.bodyLarge;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/',
          (route) => false,
        );

        throw 0;
      },
      child: Scaffold(
        body: SafeArea(
          child: PaddedScreenWidget(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/success.svg',
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Order placed successfully!',
                        style: bodyLarge,
                      ),
                      SizedBox(height: 1.5.h),
                      const Text(
                        'Your order has been processed successfully and you will receive email updates concerning your order',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  label: 'Checkout',
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/',
                      (route) => false,
                    );
                  },
                ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
