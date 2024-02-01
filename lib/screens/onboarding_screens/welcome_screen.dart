import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/app_colors.dart';
import '../../helpers/app_contants.dart';
import '../../widgets/general_widgets/app_name.dart';
import '../../widgets/general_widgets/custom_button.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/WelcomeScreen';

  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 5.h);
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var titleMedium = textTheme.titleMedium;

    return Scaffold(
      body: SafeArea(
        child: PaddedScreenWidget(
          child: Column(
            children: [
              sizedBox,
              AppName(
                size: 20.sp,
              ),
              sizedBox,
              sizedBox,
              SvgPicture.asset(AppConstants.onboarding4),
              sizedBox,
              SizedBox(height: 3.h),
              Row(
                children: [
                  Text(
                    'Welcome to ',
                    style: titleMedium?.copyWith(
                      color: AppColors.primary,
                      fontSize: 21.sp,
                    ),
                  ),
                  Text(
                    'SoleCapsule',
                    style: titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 21.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              const Text(
                'It\'s time to simplify and enhance your home automation experience.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              sizedBox,
              CustomButton(
                onTap: () => Navigator.pushNamed(
                  context,
                  '/CreateAccountScreen',
                ),
                label: 'Get Started',
              ),
              SizedBox(height: 1.h),
              CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, '/LoginScreen');
                },
                label: 'Sign in',
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
