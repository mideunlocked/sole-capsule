import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/ble_provider.dart';
import '../../provider/theme_mode_provider.dart';
import 'ble_device_tile.dart';

class BluetoothDeviciesDialog extends StatelessWidget {
  const BluetoothDeviciesDialog({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldMessengerState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    bool isLightMode =
        Provider.of<ThemeModeProvider>(context, listen: false).isLight;

    var of = Theme.of(context);
    var textTheme = of.textTheme;
    return Dialog(
      backgroundColor:
          isLightMode ? const Color(0xFFEEF5FB) : const Color(0xFF14191D),
      insetPadding: EdgeInsets.symmetric(
        vertical: 20.h,
        horizontal: 10.w,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      insetAnimationCurve: Curves.bounceIn,
      insetAnimationDuration: const Duration(seconds: 5),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Column(
          children: [
            Text(
              'Available devices',
              style: textTheme.bodyLarge?.copyWith(fontSize: 12.sp),
            ),
            SizedBox(height: 1.h),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: of.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Consumer<BleProvider>(builder: (context, blePvr, _) {
                  return ListView(
                    physics: const BouncingScrollPhysics(),
                    children: blePvr.bleDevices
                        .map(
                          (e) => BleDeviceTile(
                            name: e.platformName,
                            isSelected: e == blePvr.selectedDevice,
                            isCurrent: e == blePvr.currentDevice,
                            onTap: () => blePvr.connectToDevice(
                              context: context,
                              device: e,
                              scaffoldKey: scaffoldKey,
                            ),
                          ),
                        )
                        .toList(),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
