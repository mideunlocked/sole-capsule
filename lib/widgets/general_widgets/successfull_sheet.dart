import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'custom_button.dart';
import 'padded_screen_widget.dart';

void showSuccesfullSheet({
  required BuildContext context,
  required Widget successMessage,
  required String buttonTitle,
  required Function buttonFunction,
}) async {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    backgroundColor: Colors.transparent,
    builder: (ctx) => WillPopScope(
      onWillPop: () {
        throw 0;
      },
      child: SuccessfullSheet(
        successMesssage: successMessage,
        buttonFunction: buttonFunction,
        buttonTitle: buttonTitle,
      ),
    ),
  );
}

class SuccessfullSheet extends StatelessWidget {
  const SuccessfullSheet({
    super.key,
    required this.successMesssage,
    required this.buttonTitle,
    required this.buttonFunction,
  });

  final Widget successMesssage;
  final String buttonTitle;
  final Function buttonFunction;

  @override
  Widget build(BuildContext context) {
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
                successMesssage,
                sizedBox,
                CustomButton(
                  onTap: () {
                    buttonFunction();
                  },
                  label: buttonTitle,
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
