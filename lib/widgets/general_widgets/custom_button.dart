import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sole_capsule/widgets/general_widgets/custom_progress_inidicator.dart';

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

    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: Container(
        width: 100.w,
        height: 6.h,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: color.withOpacity(isNull ? 0.2 : 1),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? const Center(
                child: CustomProgressIndicator(),
              )
            : customWidget ??
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: icon != null,
                      child: Icon(
                        icon,
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
  }
}
