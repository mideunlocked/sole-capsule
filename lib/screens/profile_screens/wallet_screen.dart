import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/theme_mode_provider.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';

class WalletScreen extends StatelessWidget {
  static const routeName = '/WalletScreen';

  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    var sizedBox = SizedBox(height: 1.h);

    return Scaffold(
      body: Consumer<ThemeModeProvider>(builder: (context, themePvr, _) {
        bool isLight = themePvr.isLight;

        var lightTextStyle = textTheme.bodySmall?.copyWith(
          color: isLight ? Colors.black54 : Colors.white60,
        );

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WalletAppBar(
                isLight: isLight,
              ),
              sizedBox,
              sizedBox,
              PaddedScreenWidget(
                child: Text(
                  'My SOLE Credit History',
                  style: TextStyle(
                    fontSize: 13.sp,
                  ),
                ),
              ),
              sizedBox,
              Divider(
                color: isLight ? const Color(0xFFF2F2F2) : Colors.white12,
                thickness: 2,
              ),
              sizedBox,
              PaddedScreenWidget(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '14/02/2024 22:30 (UTC -3)',
                          style: textTheme.bodySmall?.copyWith(
                            color: isLight ? Colors.black54 : Colors.white54,
                            fontSize: 10.sp,
                          ),
                        ),
                        sizedBox,
                        Text(
                          'Order rebate',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.sp,
                          ),
                        ),
                        Text(
                          'Order Id.: SFV00KxBEMNlng5HFTWz',
                          style: textTheme.bodySmall?.copyWith(
                            color: isLight ? Colors.black54 : Colors.white54,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '+ USD \$9.50',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              sizedBox,
              sizedBox,
              Divider(
                thickness: 8,
                color: isLight ? const Color(0xFFF2F2F2) : Colors.white12,
              ),
              sizedBox,
              sizedBox,
              PaddedScreenWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SOLE Credit Description',
                      style: TextStyle(
                        fontSize: 13.sp,
                      ),
                    ),
                    sizedBox,
                    Text(
                      'SOLE Credit is a virtual currency that can be used to pay for your purchases at the SOLE Online Store.',
                      style: lightTextStyle,
                    ),
                    WalletDescriptionTile(
                      index: '1',
                      value:
                          'The currency of your SOLE Credit will be the same that you choose to pay with.',
                      textStyle: lightTextStyle,
                    ),
                    WalletDescriptionTile(
                      index: '2',
                      value:
                          'SOLE Wallet is non-transferable, cannot be exchanged for cash, and cannot be used outside of the official SOLE Online Store.',
                      textStyle: lightTextStyle,
                    ),
                    WalletDescriptionTile(
                      index: '3',
                      value:
                          'You can choose to use your SOLE Credit during checkout. If the amount of available SOLE Credit is less than your total order amount (excluding shipping fees), you can pay the difference with of our payment methods.',
                      textStyle: lightTextStyle,
                    ),
                    WalletDescriptionTile(
                      index: '4',
                      value:
                          'If no refund is processed from 15 to 35 days after the receipt of delivery, users will receive 1% of their total purchase value in SOLE Credit.',
                      textStyle: lightTextStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      }),
    );
  }
}

class WalletDescriptionTile extends StatelessWidget {
  const WalletDescriptionTile({
    super.key,
    required this.index,
    required this.value,
    this.textStyle,
  });

  final TextStyle? textStyle;
  final String index;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            index,
            style: textStyle,
          ),
          SizedBox(width: 2.w),
          SizedBox(
            width: 85.w,
            child: Text(
              value,
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}

class WalletAppBar extends StatelessWidget {
  const WalletAppBar({
    super.key,
    required this.isLight,
  });

  final bool isLight;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    return Container(
      color: isLight ? Colors.black : const Color(0xFF14191D),
      height: 28.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      child: Column(
        children: [
          SizedBox(
            height: 6.h,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              const Row(
                children: [
                  // CustomBackButton(
                  //   isLight: true,
                  // ),
                ],
              ),
              Text(
                'Wallet',
                style: textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available Balance',
                    style:
                        textTheme.bodyMedium?.copyWith(color: Colors.white70),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    'USD \$32.9',
                    style: textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SvgPicture.asset(
                'assets/icons/wallet.svg',
                // ignore: deprecated_member_use
                color: Colors.white,
                height: 4.h, width: 4.w,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
