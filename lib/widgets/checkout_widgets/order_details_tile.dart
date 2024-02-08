import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OrderDetailsTile extends StatelessWidget {
  const OrderDetailsTile({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      fontSize: 12.sp,
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: textStyle,
          ),
          Text(
            value,
            style: textStyle.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
