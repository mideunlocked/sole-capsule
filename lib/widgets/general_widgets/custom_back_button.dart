import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/app_contants.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.onTap,
    this.extraFunction,
  });

  final Function()? onTap;
  final bool? extraFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => extraFunction == true ? onTap!() : Navigator.pop(context),
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFD4D4D4),
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          AppConstants.backIcon,
        ),
      ),
    );
  }
}
