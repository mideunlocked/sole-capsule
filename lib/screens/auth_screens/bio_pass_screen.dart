import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/biometrics_provider.dart';
import '../../widgets/general_widgets/custom_button.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';

class BioPassScreen extends StatefulWidget {
  static const routeName = '/BioPassScreen';

  const BioPassScreen({super.key});

  @override
  State<BioPassScreen> createState() => _BioPassScreenState();
}

class _BioPassScreenState extends State<BioPassScreen> {
  String type = '';

  List<BiometricType>? availableBiometrics;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    authenticate();
  }

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: ScaffoldMessenger(
        key: _scaffoldKey,
        child: SafeArea(
          child: PaddedScreenWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 3.h),
                CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  radius: 40.sp,
                  child: Icon(
                    Icons.lock_rounded,
                    color: Colors.black,
                    size: 40.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Sole Locked',
                  style: textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 0.5.h),
                Text(
                  'Unlock with $type to Open Sole',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(fontSize: 13.sp),
                ),
                const Spacer(),
                CustomButton(
                  onTap: authenticate,
                  label: 'Use Biometrics',
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void authenticate() async {
    var bioPvr = Provider.of<BiometricsProvider>(context, listen: false);

    await bioPvr.checkBiometric();
    await bioPvr.checkAvailableBiometrics();
    await bioPvr.getBioStatus();

    availableBiometrics = bioPvr.biometricsTypes;

    switch (availableBiometrics?.first) {
      case BiometricType.face:
        type = 'Face ID';
        break;
      default:
        type = 'Biometrics';
    }

    await Future.delayed(
      Duration.zero,
      () async {
        await bioPvr.authenticateWithBiometrics(
          context: context,
          scaffoldKey: _scaffoldKey,
        );
      },
    );
  }
}
