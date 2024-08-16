import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sole_capsule/widgets/general_widgets/padded_screen_widget.dart';

import '../../widgets/general_widgets/custom_button.dart';
import '../auth_screens/create_account_screen.dart';
import '../auth_screens/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/WelcomeScreen';

  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var titleMedium = textTheme.titleMedium;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: 100.h,
            width: 100.w,
            child: Image.asset(
              'assets/images/onboarding/sole_frame.png',
            ),
          ),
          Container(
            width: 100.w,
            height: 35.h,
            decoration: const BoxDecoration(
              color: Color(0xFFF1F1F1),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: PaddedScreenWidget(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome to ',
                        style: titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 21.sp,
                        ),
                      ),
                      Text(
                        'SoleCapsule',
                        style: titleMedium?.copyWith(
                          color: Colors.black,
                          fontSize: 21.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  const Text(
                    'It\'s time to put your favorite Pair on Display',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        onTap: () =>
                            Navigator.pushNamed(context, LoginScreen.routeName),
                        isBoxed: true,
                        width: 42.w,
                        label: 'Log In',
                        fontBold: true,
                      ),
                      CustomButton(
                        onTap: () => Navigator.pushNamed(
                            context, CreateAccountScreen.routeName),
                        isBoxed: true,
                        width: 42.w,
                        label: 'Sign Up',
                        color: const Color(0xFFF1F1F1),
                        isBordered: true,
                        fontBold: true,
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
