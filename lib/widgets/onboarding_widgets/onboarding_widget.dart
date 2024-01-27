import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/app_colors.dart';
import '../../models/onboarding.dart';

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({
    super.key,
    required this.onboarding,
  });

  final Onboarding onboarding;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var titleMedium = textTheme.titleMedium;
    var sizedBox = SizedBox(height: 5.h);

    return Column(
      children: [
        SvgPicture.asset(onboarding.illustration),
        sizedBox,
        SizedBox(height: 3.h),
        Row(
          children: [
            Text(
              onboarding.title.first,
              style: titleMedium?.copyWith(
                color: AppColors.primary,
              ),
            ),
            Text(
              onboarding.title.last,
              style: titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        Text(
          onboarding.subtitle,
          style: const TextStyle(
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
