import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/theme_mode_provider.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isLight =
        Provider.of<ThemeModeProvider>(context, listen: false).isLight;

    return Container(
      padding: EdgeInsets.all(15.sp),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: CircularProgressIndicator(
        color: Colors.grey.shade200,
        backgroundColor: isLight ? Colors.black : const Color(0xFF14191D),
        strokeWidth: 3,
      ),
    );
  }
}
