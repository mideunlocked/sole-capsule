import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/theme_mode_provider.dart';
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
    return PopScope(
      onPopInvoked: (_) async {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/',
          (route) => false,
        );

        throw 0;
      },
      child: Scaffold(
        body: PaddedScreenWidget(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<ThemeModeProvider>(
                        builder: (context, tmPvr, child) {
                      bool isLightMode = tmPvr.isLight;
        
                      return SvgPicture.asset(
                        isLightMode
                            ? 'assets/icons/success.svg'
                            : 'assets/icons/success2.svg',
                      );
                    }),
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
    );
  }
}
