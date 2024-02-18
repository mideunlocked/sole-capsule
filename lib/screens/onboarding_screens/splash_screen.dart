import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/auth_helper.dart';
import '../../widgets/general_widgets/app_name.dart';
import '../app.dart';
import 'onboarding_screen.dart';

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
      () {
        final Auth auth = Auth();
        final bool isLogged = auth.isLogged();

        Navigator.pushNamedAndRemoveUntil(
            context,
            isLogged ? App.rouetName : OnboardingScreen.routeName,
            (route) => false);
      },
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
