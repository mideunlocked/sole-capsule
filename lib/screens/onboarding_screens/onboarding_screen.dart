import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/onboarding_data.dart';
import '../../widgets/general_widgets/app_name.dart';
import '../../widgets/general_widgets/custom_button.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';
import '../../widgets/onboarding_widgets/onboarding_indicator.dart';
import '../../widgets/onboarding_widgets/onboarding_widget.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = '/OnboardingScreen';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;

  final pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    super.dispose();

    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 5.h);

    return Scaffold(
      body: PaddedScreenWidget(
        child: Column(
          children: [
            sizedBox,
            AppName(
              size: 20.sp,
            ),
            sizedBox,
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (value) =>
                    setState(() => currentIndex = value),
                itemCount: onboardingData.length,
                itemBuilder: (ctx, index) => OnboardingWidget(
                  onboarding: onboardingData[index],
                ),
              ),
            ),
            SizedBox(
              height: 0.4.h,
              width: 100.w,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (ctx, index) {
                  bool isCurrent = index == currentIndex;
      
                  return OnboardingIndicator(isCurrent: isCurrent);
                },
              ),
            ),
            sizedBox,
            CustomButton(
              label: 'Next',
              onTap: () {
                if (currentIndex != 2) {
                  pageController.nextPage(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeIn,
                  );
                } else {
                  Navigator.pushNamed(context, '/WelcomeScreen');
                }
              },
            ),
            sizedBox,
          ],
        ),
      ),
    );
  }
}
