import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';

import '../../helpers/app_colors.dart';
import '../../provider/box_provider.dart';
import '../../provider/theme_mode_provider.dart';
import '../../provider/wifi_provider.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/general_widgets/custom_button.dart';
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

  String wifiId = '';

  void getWifiId(String id) => setState(() => wifiId = id);

  @override
  Widget build(BuildContext context) {
    var themePvr = Provider.of<ThemeModeProvider>(context, listen: false);
    bool isLight = themePvr.isLight;

    var subTextStyle = TextStyle(
      color: isLight ? Colors.black38 : Colors.white54,
    );

    return PopScope(
      canPop: true,
      onPopInvoked: (_) {
        Future.delayed(Duration.zero, resetStepper);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ScaffoldMessenger(
          key: _scaffoldKey,
          child: SafeArea(
            child: PaddedScreenWidget(
              child: Column(
                children: [
                  const CustomAppBar(
                    title: 'Connect Wi-Fi',
                  ),
                  SizedBox(height: 3.h),
                  Expanded(
                    child:
                        Consumer<WifiProvider>(builder: (context, wifiPvr, _) {
                      return Stepper(
                        // margin: EdgeInsets.only(bottom: 10.h),
                        controlsBuilder: (context, details) =>
                            const SizedBox.shrink(),
                        currentStep: wifiPvr.currentStep,
                        stepIconBuilder: (stepIndex, stepState) => Container(
                          padding: EdgeInsets.all(1.sp),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isLight
                                ? Colors.black
                                : const Color.fromARGB(255, 26, 32, 37),
                          ),
                          child: Text(
                            (stepIndex + 1).toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        connectorColor:
                            const WidgetStatePropertyAll(AppColors.primary),

                        steps: [
                          Step(
                            title: const Text('Scan'),
                            subtitle: Text(
                              'Scan available Wi-Fi',
                              style: subTextStyle,
                            ),
                            content: Column(
                              children: [
                                isLight
                                    ? LottieBuilder.asset(
                                        // animate: value.isLoading,
                                        'assets/lottie/scan_wifi.json',
                                      )
                                    : LottieBuilder.asset(
                                        // animate: value.isLoading,
                                        'assets/lottie/scan_wifi_dark.json',
                                      ),
                                CustomButton(
                                  onTap: scanAvailableWifi,
                                  isLoading: wifiPvr.isLoading,
                                  label: 'Scan',
                                ),
                              ],
                            ),
                          ),
                          Step(
                            title: const Text('Select'),
                            subtitle: Text(
                              'Select Wi-Fi',
                              style: subTextStyle,
                            ),
                            content: SizedBox(
                              height: 40.h,
                              width: 100.w,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                decoration: BoxDecoration(
                                  color: isLight
                                      ? const Color.fromARGB(255, 235, 235, 235)
                                      : const Color(0xFF101417),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListView(
                                  children: wifiPvr.wifiList
                                      .map(
                                        (e) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                getWifiId(e.ssid);
                                                wifiPvr.next();
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2.h),
                                                child: Text(e.ssid),
                                              ),
                                            ),
                                            const Divider(),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                          ),
                          Step(
                            title: const Text('Password'),
                            subtitle: Text(
                              'Input Wi-Fi Password',
                              style: subTextStyle,
                            ),
                            content: Column(
                              children: [
                                SizedBox(height: 2.h),
                                CustomTextField(
                                  controller: passwordTextEditCtr,
                                  title: 'Network Password',
                                  hint: 'Wi-Fi Password',
                                  inputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    wifiPvr.next();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Step(
                            title: const Text('Save'),
                            subtitle: Text(
                              'Save Wi-Fi to Pod',
                              style: subTextStyle,
                            ),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 2.h),
                                wifiCredTile(
                                  title: 'Wi-Fi ID:',
                                  value: wifiId,
                                  isLight: isLight,
                                ),
                                wifiCredTile(
                                  title: 'Password:',
                                  value: passwordTextEditCtr.text.trim(),
                                  isLight: isLight,
                                ),
                                CustomButton(
                                  label: 'Connect',
                                  onTap: connectPodToWiFi,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding wifiCredTile({
    required bool isLight,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: isLight ? Colors.black45 : Colors.white54),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
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

  void scanAvailableWifi() async {
    var wifiPvr = Provider.of<WifiProvider>(context, listen: false);

    await wifiPvr.startWifiScan();
    await wifiPvr.getScannedWifi();
  }

  void resetStepper() {
    if (mounted) {
      var wifiPvr = Provider.of<WifiProvider>(context, listen: false);

      wifiPvr.resetCurrentStep();
    }
  }

  void connectPodToWiFi() async {
    var boxPvr = Provider.of<BoxProvider>(context, listen: false);

    String boxId = ModalRoute.of(context)!.settings.arguments as String;

    final isValid = _formKey.currentState?.validate();

    if (isValid == false) {
      return;
    } else {
      await boxPvr.passWiFiCredToPod(
        id: boxId,
        networkId: wifiId,
        password: passwordTextEditCtr.text.trim(),
        context: context,
        scaffoldKey: _scaffoldKey,
      );
    }
  }
}

// Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   const CustomAppBar(
//                     title: 'Connect Wi-Fi',
//                   ),
//                   SizedBox(height: 3.h),
//                   CustomTextField(
//                     controller: networkIdTextEditCtr,
//                     title: 'Network ID',
//                     hint: 'Wi-Fi ID',
//                   ),
//                   SizedBox(height: 2.h),
//                   CustomTextField(
//                     controller: passwordTextEditCtr,
//                     title: 'Network Password',
//                     hint: 'Wi-Fi Password',
//                     inputAction: TextInputAction.done,
//                   ),
//                   SizedBox(height: 7.h),
//                   const Text(
//                     'How to Find Your Wi-Fi Network Name and Password',
//                   ),
//                   SizedBox(height: 2.h),
//                   Platform.isAndroid
//                       ? Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             stepText(
//                                 text:
//                                     '1. Open Settings and go to "Network & Internet".'),
//                             stepText(
//                                 text:
//                                     '2. Tap "Wi-Fi" and select your network.'),
//                             stepText(
//                                 text:
//                                     '3. Tap "Share" and authenticate. The network\'s SSID and password will be displayed.'),
//                           ],
//                         )
//                       : Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             stepText(text: '1. Open Settings and tap "Wi-Fi"'),
//                             stepText(
//                                 text:
//                                     'Tap the info icon (i) next to your network. (Password may not be directly visible, use Keychain Access on Mac if needed).'),
//                           ],
//                         ),
//                   const Spacer(),
//                   CustomButton(
//                     label: 'Connect',
//                     onTap: connectPodToWiFi,
//                   ),
//                   SizedBox(height: 2.h),
//                 ],
//               ),
//             )
