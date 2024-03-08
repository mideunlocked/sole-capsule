import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/theme_mode_provider.dart';

class DeleteBoxSheetButton extends StatelessWidget {
  const DeleteBoxSheetButton({
    super.key,
    this.isInverted = false,
    required this.label,
    required this.onTap,
  });

  final Function()? onTap;
  final bool isInverted;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Consumer<ThemeModeProvider>(builder: (context, tmPvr, child) {
        bool isLightMode = tmPvr.isLight;

        return Container(
          width: 40.w,
          padding: EdgeInsets.symmetric(
            vertical: 1.5.h,
          ),
          decoration: BoxDecoration(
            border: isInverted && !isLightMode
                ? null
                : Border.all(
                    color: Colors.grey.shade400,
                  ),
            borderRadius: BorderRadius.circular(40),
            color: isInverted ? Colors.red : null,
            boxShadow: isLightMode
                ? [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 10,
                      spreadRadius: 10,
                    ),
                  ]
                : [],
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isInverted ? Colors.white : null,
            ),
          ),
        );
      }),
    );
  }
}
