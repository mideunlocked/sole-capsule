import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_mode_provider.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isLight =
        Provider.of<ThemeModeProvider>(context, listen: false).isLight;

    return CircularProgressIndicator(
      color: Colors.white,
      backgroundColor: isLight ? Colors.black38 : const Color(0xFF14191D),
      strokeWidth: 1,
    );
  }
}
