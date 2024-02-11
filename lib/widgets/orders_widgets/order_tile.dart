import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 1.5.h);

    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var customTextStyle = textTheme.bodyMedium?.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
    );

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/sole-capsule.appspot.com/o/sole-capsule.jpeg?alt=media&token=6ea04961-11d7-48a4-9bbd-a37924f6b27d',
                height: 20.h,
                width: 35.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 5.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBox,
                Text(
                  'Sole Capsule',
                  style: customTextStyle,
                ),
                SizedBox(height: 1.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                    vertical: 1.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    '\$ 34.00',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
