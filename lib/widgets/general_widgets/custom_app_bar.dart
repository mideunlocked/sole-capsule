import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'custom_back_button.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    return Column(
      children: [
        SizedBox(height: 2.h),
        Stack(
          alignment: Alignment.center,
          children: [
            const Row(
              children: [
                CustomBackButton(),
              ],
            ),
            Text(
              title,
              style: textTheme.bodyLarge,
            ),
          ],
        ),
      ],
    );
  }
}
