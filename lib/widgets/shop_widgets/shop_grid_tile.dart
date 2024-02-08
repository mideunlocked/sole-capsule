import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ShopGridTile extends StatelessWidget {
  const ShopGridTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    var bodyLarge = textTheme.bodyLarge;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: 100.w,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 3.w,
            vertical: 2.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sole Capsule',
                style: bodyLarge?.copyWith(fontSize: 15.sp),
              ),
              SizedBox(height: 1.h),
              const Text(
                'Autumn And Winter Casual cotton-padded jacket',
              ),
              SizedBox(height: 1.h),
              Text(
                '₹499',
                style: textTheme.labelMedium?.copyWith(
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            'https://firebasestorage.googleapis.com/v0/b/sole-capsule.appspot.com/o/sole-capsule.jpeg?alt=media&token=6ea04961-11d7-48a4-9bbd-a37924f6b27d',
          ),
        ),
      ],
    );
  }
}
