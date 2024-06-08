import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sole_capsule/widgets/general_widgets/custom_button.dart';

import '../../provider/box_provider.dart';
import '../../provider/theme_mode_provider.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/general_widgets/custom_text_field.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';

class ConnectWifiScreen extends StatefulWidget {
  static const routeName = '/ConnectWifiScreen';

  const ConnectWifiScreen({super.key});

  @override
  State<ConnectWifiScreen> createState() => _ConnectWifiScreenState();
}

class _ConnectWifiScreenState extends State<ConnectWifiScreen> {
  final networkIdTextEditCtr = TextEditingController();
  final passwordTextEditCtr = TextEditingController();

  @override
  void dispose() {
    networkIdTextEditCtr.dispose();
    passwordTextEditCtr.dispose();

    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScaffoldMessenger(
        key: _scaffoldKey,
        child: SafeArea(
          child: PaddedScreenWidget(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const CustomAppBar(
                    title: 'Connect Wi-Fi',
                  ),
                  SizedBox(height: 3.h),
                  CustomTextField(
                    controller: networkIdTextEditCtr,
                    title: 'Network ID',
                    hint: 'Wi-Fi ID',
                  ),
                  SizedBox(height: 2.h),
                  CustomTextField(
                    controller: passwordTextEditCtr,
                    title: 'Network Password',
                    hint: 'Wi-Fi Password',
                    inputAction: TextInputAction.done,
                  ),
                  SizedBox(height: 7.h),
                  const Text(
                    'How to Find Your Wi-Fi Network Name and Password',
                  ),
                  SizedBox(height: 2.h),
                  Platform.isAndroid
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            stepText(
                                text:
                                    '1. Open Settings and go to "Network & Internet".'),
                            stepText(
                                text:
                                    '2. Tap "Wi-Fi" and select your network.'),
                            stepText(
                                text:
                                    '3. Tap "Share" and authenticate. The network\'s SSID and password will be displayed.'),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            stepText(text: '1. Open Settings and tap "Wi-Fi"'),
                            stepText(
                                text:
                                    'Tap the info icon (i) next to your network. (Password may not be directly visible, use Keychain Access on Mac if needed).'),
                          ],
                        ),
                  const Spacer(),
                  CustomButton(
                    label: 'Connect',
                    onTap: connectPodToWiFi,
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding stepText({required String text}) {
    var themePvr = Provider.of<ThemeModeProvider>(context, listen: false);
    bool isLightMode = themePvr.isLight;

    return Padding(
      padding: EdgeInsets.only(bottom: 1.5.h),
      child: Text(
        text,
        style: TextStyle(
          color: isLightMode ? Colors.black54 : Colors.white60,
        ),
      ),
    );
  }

  void connectPodToWiFi() async {
    var boxPvr = Provider.of<BoxProvider>(context, listen: false);

    String boxId = ModalRoute.of(context)!.settings.arguments as String;

    final isValid = _formKey.currentState!.validate();

    if (isValid == false) {
      return;
    } else {
      await boxPvr.passWiFiCredToPod(
        id: boxId,
        networkId: networkIdTextEditCtr.text.trim(),
        password: passwordTextEditCtr.text.trim(),
        context: context,
        scaffoldKey: _scaffoldKey,
      );
    }
  }
}
