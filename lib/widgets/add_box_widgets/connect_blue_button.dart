import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/theme_mode_provider.dart';

class ConnectBlueButton extends StatelessWidget {
  const ConnectBlueButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.circular(15);

    return InkWell(
      onTap: () {},
      borderRadius: borderRadius,
      child: Consumer<ThemeModeProvider>(builder: (context, tmPvr, child) {
        bool isLightMode = tmPvr.isLight;

        return Container(
          width: 100.w,
          height: 7.h,
          padding: EdgeInsets.symmetric(horizontal: 1.w),
          decoration: BoxDecoration(
            color:
                isLightMode ? const Color(0xFFEEF5FB) : const Color(0xFF14191D),
            border: isLightMode
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
              const Text('Pair with device'),
            ],
          ),
        );
      }),
    );
  }
}
