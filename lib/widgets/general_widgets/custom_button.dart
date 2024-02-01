import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.label,
    this.color = const Color(0xFF000218),
  });

  final Function() onTap;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.circular(30);
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100.w,
        height: 6.h,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: color,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
