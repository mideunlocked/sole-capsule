import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/app_contants.dart';
import '../../provider/theme_mode_provider.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.onTap,
    this.isLight = false,
    this.extraFunction,
  });

  final bool isLight;
  final Function()? onTap;
  final bool? extraFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => extraFunction == true ? onTap!() : Navigator.pop(context),
      borderRadius: BorderRadius.circular(50),
      child: Consumer<ThemeModeProvider>(builder: (context, tmPvr, child) {
        bool isLightMode = tmPvr.isLight;

        return Container(
          padding: EdgeInsets.all(12.sp),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFD4D4D4),
            ),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            AppConstants.backIcon,
            // ignore: deprecated_member_use
            color: isLightMode
                ? isLight
                    ? Colors.white
                    : null
                : Colors.white,
          ),
        );
      }),
    );
  }
}
