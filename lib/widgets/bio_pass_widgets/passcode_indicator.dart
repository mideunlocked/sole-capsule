import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/app_colors.dart';

class PasscodeIndicator extends StatelessWidget {
  const PasscodeIndicator({
    super.key,
    required this.passcode,
    required this.index,
  });

  final String passcode;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0),
      child: Icon(
        Icons.circle_rounded,
        size: 15,
        color:
            index < passcode.length ? AppColors.tetiary : Colors.grey.shade300,
      ),
    );
  }
}
