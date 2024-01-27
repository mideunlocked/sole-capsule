import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/general_widget/app_name.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/SplashScreen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    navigateToNextScreen();
  }

  void navigateToNextScreen() async {
    await Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushNamedAndRemoveUntil(
          context, '/OnboardingScreen', (route) => false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppName(
              size: 22.sp,
            ),
          ],
        ),
      ),
    );
  }
}
