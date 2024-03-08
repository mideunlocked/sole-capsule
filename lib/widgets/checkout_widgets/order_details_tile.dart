import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OrderDetailsTile extends StatelessWidget {
  const OrderDetailsTile({
    super.key,
    required this.title,
    required this.value,
    this.subValue,
  });

  final String title;
  final String value;
  final String? subValue;

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      fontSize: 12.sp,
    );

    bool hasSub = subValue == 'null';

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        children: [
          Text(
            title,
            style: textStyle,
          ),
          const Spacer(),
          Text(
            value,
            style: textStyle.copyWith(
              fontWeight: hasSub ? null : FontWeight.w600,
              decoration: hasSub ? TextDecoration.lineThrough : null,
              color: hasSub ? Colors.grey : null,
            ),
          ),
          Visibility(
            visible: hasSub,
            child: Text(
              subValue ?? '',
              style: textStyle.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
