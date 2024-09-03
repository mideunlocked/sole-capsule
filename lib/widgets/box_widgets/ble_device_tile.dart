import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BleDeviceTile extends StatelessWidget {
  const BleDeviceTile({
    super.key,
    required this.name,
    required this.isSelected,
    this.onTap,
    this.isCurrent,
  });

  final String name;
  final bool? isSelected;
  final bool? isCurrent;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 12.sp,
                  ),
                ),
                isCurrent ?? false
                    ? const Icon(Icons.check_rounded)
                    : Visibility(
                        visible: isSelected ?? false,
                        child: const CupertinoActivityIndicator(),
                      ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
