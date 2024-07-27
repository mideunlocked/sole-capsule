import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../general_widgets/sole_app_icon.dart';

class ShoppingScreenAppBar extends StatelessWidget {
  const ShoppingScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    var bodyLarge = textTheme.bodyLarge;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Shop',
          style: bodyLarge,
        ),
        const SoleAppIcon(),
        InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            '/CartScreen',
          ),
          child: CircleAvatar(
            maxRadius: 15.sp,
            backgroundColor: const Color(0xFFD9D9D9),
            child: SvgPicture.asset(
              'assets/icons/cart.svg',
              height: 3.h,
              width: 3.w,
            ),
          ),
        ),
      ],
    );
  }
}
