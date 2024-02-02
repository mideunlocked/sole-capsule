import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
      child: Container(
        width: 100.w,
        height: 7.h,
        padding: EdgeInsets.symmetric(horizontal: 1.w),
        decoration: BoxDecoration(
          color: const Color(0xFFEEF5FB),
          border: Border.all(
            color: const Color(0xFFB7B7B7),
          ),
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
      ),
    );
  }
}
