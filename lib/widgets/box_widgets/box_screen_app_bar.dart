import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../general_widgets/custom_back_button.dart';

class BoxAppBar extends StatelessWidget {
  const BoxAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomBackButton(
          onTap: () => Navigator.pushReplacementNamed(context, '/'),
        ),
        InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            '/BoxSettingsScreen',
          ),
          borderRadius: BorderRadius.circular(50),
          child: Container(
            padding: EdgeInsets.all(8.sp),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFD4D4D4),
              ),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/icons/settings.svg',
              height: 3.h,
              width: 3.w,
            ),
          ),
        ),
      ],
    );
  }
}
