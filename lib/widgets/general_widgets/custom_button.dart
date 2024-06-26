import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sole_capsule/widgets/general_widgets/custom_progress_inidicator.dart';

import '../../provider/theme_mode_provider.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    this.label,
    this.color = const Color(0xFF000218),
    this.isLoading = false,
    this.icon,
    this.customWidget,
  });

  final Widget? customWidget;
  final Function()? onTap;
  final bool isLoading;
  final IconData? icon;
  final String? label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.circular(30);
    bool isNull = onTap == null;

    return Consumer<ThemeModeProvider>(
      builder: (context, tmPvr, child) {
        bool isLightMode = tmPvr.isLight;

        return Container(
          width: 100.w,
          height: 6.h,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: isLightMode
                ? color.withOpacity(isNull ? 0.2 : 1)
                : const Color(0xFF101417),
            boxShadow: const [
              BoxShadow(
                color: Colors.white10,
                spreadRadius: 1,
                blurStyle: BlurStyle.normal,
                blurRadius: 1,
                offset: Offset.infinite,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: isLoading
              ? const Center(
                  child: CustomProgressIndicator(),
                )
              : InkWell(
                  onTap: onTap,
                  borderRadius: borderRadius,
                  splashColor: Colors.white,
                  child: customWidget ??
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: icon != null,
                            child: Row(
                              children: [
                                Icon(
                                  icon,
                                  color: isLightMode ? null : Colors.white,
                                ),
                                SizedBox(width: 3.w),
                              ],
                            ),
                          ),
                          Text(
                            label ?? '',
                            style: TextStyle(
                              color: color == const Color(0xFF000218)
                                  ? Colors.white
                                  : null,
                            ),
                          ),
                        ],
                      ),
                ),
        );
      },
    );
  }
}
