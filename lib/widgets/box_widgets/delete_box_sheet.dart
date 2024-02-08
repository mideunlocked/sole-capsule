import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../general_widgets/padded_screen_widget.dart';

void showDeleteBoxSheet({
  required BuildContext context,
}) async {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    backgroundColor: Colors.transparent,
    builder: (ctx) => const DeleteBoxSheet(),
  );
}

class DeleteBoxSheet extends StatelessWidget {
  const DeleteBoxSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 3.h);

    var of = Theme.of(context);
    var textTheme = of.textTheme;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 40.h,
        ),
        Container(
          height: 33.h,
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
                  'Are you sure you want to delete this box?',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(fontSize: 16.sp),
                ),
                sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DeleteBoxSheetButton(
                      label: 'Cancel',
                      onTap: () => Navigator.pop(context),
                    ),
                    DeleteBoxSheetButton(
                      label: 'Delete',
                      isInverted: true,
                      onTap: () {},
                    ),
                  ],
                ),
                sizedBox,
                sizedBox,
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 24.h,
          child: Container(
            padding: EdgeInsets.all(5.sp),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 40.sp,
              backgroundColor: Colors.black,
              child: SvgPicture.asset(
                'assets/icons/delete.svg',
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DeleteBoxSheetButton extends StatelessWidget {
  const DeleteBoxSheetButton({
    super.key,
    this.isInverted = false,
    required this.label,
    required this.onTap,
  });

  final Function()? onTap;
  final bool isInverted;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40.w,
        padding: EdgeInsets.symmetric(
          vertical: 1.5.h,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade400,
          ),
          borderRadius: BorderRadius.circular(40),
          color: isInverted ? Colors.red : null,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 10,
              spreadRadius: 10,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isInverted ? Colors.white : null,
          ),
        ),
      ),
    );
  }
}
