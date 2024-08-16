import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/app_colors.dart';
import '../../models/onboarding.dart';

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({
    super.key,
    required this.onboarding,
    required this.isColorOpposite,
  });

  final Onboarding onboarding;
  final bool isColorOpposite;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var titleMedium = textTheme.titleMedium;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 8.h),
        SizedBox(
          height: 35.h,
          child: onboarding.illustration.contains('0')
              ? SizedBox(
                  height: 30.h,
                )
              : Center(
                  child: SvgPicture.asset(
                  onboarding.illustration,
                  fit: BoxFit.cover,
                )),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              onboarding.title.first,
              style: titleMedium?.copyWith(
                color: isColorOpposite ? Colors.white : AppColors.primary,
              ),
            ),
            Text(
              onboarding.title.last,
              style: titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: isColorOpposite ? Colors.white60 : Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        Text(
          onboarding.subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isColorOpposite ? Colors.white60 : Colors.black54,
          ),
        ),
      ],
    );
  }
}
