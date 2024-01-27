import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../general_widget/custom_button.dart';
import '../general_widget/padded_screen_widget.dart';

class ResetSuccessfullSheet extends StatelessWidget {
  const ResetSuccessfullSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var titleMedium = textTheme.titleMedium;

    var sizedBox = SizedBox(height: 5.h);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 50.h,
        ),
        Container(
          height: 35.h,
          width: 100.w,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            color: Colors.white,
          ),
          child: PaddedScreenWidget(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Password Reset Done!',
                  style: titleMedium?.copyWith(fontSize: 20.sp),
                ),
                SizedBox(height: 0.5.h),
                const Text(
                  'Your password has been reset successfully, you can now login with your new password.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54),
                ),
                sizedBox,
                CustomButton(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/LoginScreen', (route) => false);
                  },
                  label: 'Login',
                ),
                sizedBox,
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 27.h,
          child: Container(
            padding: EdgeInsets.all(5.sp),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 40.sp,
              backgroundColor: Colors.black,
              child: Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 40.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
