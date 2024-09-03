import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/theme_mode_provider.dart';

class BuildPinButton extends StatelessWidget {
  const BuildPinButton({
    super.key,
    required this.number,
    required this.onPressed,
  });

  final int number;
  final Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    var themePvr = Provider.of<ThemeModeProvider>(context, listen: false);

    bool isLight = themePvr.isLight;

    return TextButton(
      onPressed: () => onPressed(number),
      child: Text(
        number.toString(),
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: isLight ? Colors.black : Colors.white,
              fontSize: 20.sp,
            ),
      ),
    );
  }
}
