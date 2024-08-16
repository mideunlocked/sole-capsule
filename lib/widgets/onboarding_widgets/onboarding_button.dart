import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class OnboardingButton extends StatelessWidget {
  const OnboardingButton({
    super.key,
    this.onTap,
    required this.width,
    required this.colorsOpposite,
  });

  final Function()? onTap;
  final double width;
  final bool colorsOpposite;

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.circular(15);

    return Container(
      width: width,
      height: 6.5.h,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: colorsOpposite ? Colors.white : const Color(0xFF101417),
        boxShadow: [
          BoxShadow(
            color: colorsOpposite ? Colors.white30 : Colors.black54,
            spreadRadius: !colorsOpposite ? 2 : 5,
            blurStyle: BlurStyle.normal,
            blurRadius: !colorsOpposite ? 2 : 5,
            offset: const Offset(0.5, 0.5),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        splashColor: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Next',
              style: TextStyle(
                color: colorsOpposite ? Colors.black : Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 3.w),
            SvgPicture.asset(
              'assets/icons/arrow_forward.svg',
              // ignore: deprecated_member_use
              color: colorsOpposite ? Colors.black : null,
            ),
          ],
        ),
      ),
    );
  }
}
