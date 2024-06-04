import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/ble_provider.dart';
import '../../provider/theme_mode_provider.dart';

class ConnectBlueButton extends StatelessWidget {
  const ConnectBlueButton({
    super.key,
    this.onTap,
  });

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.circular(15);

    var tmPvr = Provider.of<ThemeModeProvider>(context, listen: false);
    bool isLightMode = tmPvr.isLight;

    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      splashColor: Colors.white30,
      child: Consumer<BleProvider>(builder: (context, blePvr, child) {
        bool isConnected = blePvr.currentDevice != null;

        return Container(
          width: 100.w,
          height: 7.h,
          padding: EdgeInsets.symmetric(horizontal: 1.w),
          decoration: BoxDecoration(
            color: isConnected
                ? Colors.green
                : isLightMode
                    ? const Color(0xFFEEF5FB)
                    : const Color(0xFF14191D),
            border: isLightMode || !isConnected
                ? Border.all(
                    color: const Color(0xFFB7B7B7),
                  )
                : null,
            borderRadius: borderRadius,
          ),
          child: Row(
            children: [
              Icon(
                Icons.bluetooth_rounded,
                color: Colors.blue.shade900,
              ),
              SizedBox(width: 2.w),
              Text(
                isConnected ? 'Device connected' : 'Pair with device',
                style: TextStyle(color: isConnected ? Colors.white : null),
              ),
            ],
          ),
        );
      }),
    );
  }
}
