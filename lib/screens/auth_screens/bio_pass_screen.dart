import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/biometrics_provider.dart';
import '../../widgets/bio_pass_widgets/custom_passcode_widge.dart';
// import '../../widgets/general_widgets/custom_button.dart';
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

  String passcode = '';

  var passcodeController = TextEditingController();

  String? errorText;

  @override
  void initState() {
    super.initState();

    passcodeController.addListener(_listenToController);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    authenticate();
  }

  @override
  void dispose() {
    super.dispose();

    passcodeController.dispose();
  }

  void _listenToController() {
    if (passcodeController.text.length == 6) {
      if (passcodeController.text.trim() == passcode) {
        authenticate();
      } else {
        setState(() => errorText = 'Invalid passcode');
      }
    }
  }

  void getPassCode(String passcode) =>
      setState(() => passcodeController.text = passcode);

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
                SizedBox(height: 0.5.h),
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
                // SizedBox(height: 0.5.h),
                // Text(
                //   'Unlock with $type to Open Sole',
                //   textAlign: TextAlign.center,
                //   style: textTheme.bodyMedium?.copyWith(fontSize: 13.sp),
                // ),
                SizedBox(height: 3.h),
                CustomPasscodeWidget(
                  getPassCode: getPassCode,
                  errorText: errorText,
                  additionalButtonFunction: authenticate,
                ),
                SizedBox(height: 3.h),
                // CustomButton(
                //   onTap: authenticate,
                //   label: 'Use Biometrics',
                // ),
                // SizedBox(height: 2.h),
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
