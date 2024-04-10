import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/general_widgets/custom_back_button.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';

class WalletScreen extends StatelessWidget {
  static const routeName = '/WalletScreen';

  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    var sizedBox = SizedBox(height: 1.h);

    var lightTextStyle = textTheme.bodySmall?.copyWith(
      color: Colors.black54,
    );

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WalletAppBar(),
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
          const Divider(
            color: Color(0xFFF2F2F2),
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
                        color: Colors.black54,
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
                        color: Colors.black54,
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
          const Divider(
            thickness: 8,
            color: Color(0xFFF2F2F2),
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
                const WalletDescriptionTile(
                  index: '1',
                  value:
                      'The currency of your SOLE Credit will be the same that you choose to pay with.',
                ),
                const WalletDescriptionTile(
                  index: '2',
                  value:
                      'SOLE Wallet is non-transferable, cannot be exchanged for cash, and cannot be used outside of the official SOLE Online Store.',
                ),
                const WalletDescriptionTile(
                  index: '3',
                  value:
                      'You can choose to use your SOLE Credit during checkout. If the amount of available SOLE Credit is less than your total order amount (excluding shipping fees), you can pay the difference with of our payment methods.',
                ),
                const WalletDescriptionTile(
                  index: '4',
                  value:
                      'If no refund is processed from 15 to 35 days after the receipt of delivery, users will receive 1% of their total purchase value in SOLE Credit.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WalletDescriptionTile extends StatelessWidget {
  const WalletDescriptionTile({
    super.key,
    required this.index,
    required this.value,
  });

  final String index;
  final String value;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    var lightTextStyle = textTheme.bodySmall?.copyWith(
      color: Colors.black54,
    );

    return Padding(
      padding: EdgeInsets.only(top: 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            index,
            style: lightTextStyle,
          ),
          SizedBox(width: 2.w),
          SizedBox(
            width: 85.w,
            child: Text(
              value,
              style: lightTextStyle,
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
  });

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    return Container(
      color: Colors.black,
      height: 28.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      child: Column(
        children: [
          SizedBox(
            height: 4.h,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              const Row(
                children: [
                  CustomBackButton(
                    isLight: true,
                  ),
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
