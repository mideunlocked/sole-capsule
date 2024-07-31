import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/auth_helper.dart';
import '../../provider/biometrics_provider.dart';
import '../../services/vibrate.dart';
import '../../widgets/general_widgets/app_name.dart';
import '../app.dart';
import '../auth_screens/bio_pass_screen.dart';
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

    Vibrate.vibrate(duration: 3);

    Future.delayed(Duration.zero, () async {
      var bioPvr = Provider.of<BiometricsProvider>(context, listen: false);

      bioPvr.checkLocalAuthSupported();
      await bioPvr.checkBiometric();
      await bioPvr.checkAvailableBiometrics();
      await bioPvr.getBioStatus();
    });

    navigateToNextScreen();
  }

  void navigateToNextScreen() async {
    var bioPvr = Provider.of<BiometricsProvider>(context, listen: false);

    await Future.delayed(
      const Duration(seconds: 3),
      () {
        final Auth auth = Auth();
        final bool isLogged = auth.isLogged();

        Navigator.pushNamedAndRemoveUntil(
            context,
            isLogged
                ? bioPvr.bioEnabled
                    ? BioPassScreen.routeName
                    : App.rouetName
                : OnboardingScreen.routeName,
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
