import 'package:flutter/material.dart';

import '../general_widgets/custom_back_button.dart';
import '../general_widgets/custom_icon_button.dart';

class BoxAppBar extends StatelessWidget {
  const BoxAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomBackButton(
          onTap: () => Navigator.pushReplacementNamed(context, '/'),
        ),
        CustomIconButton(
          icon: 'settings',
          onTap: () => Navigator.pushNamed(
            context,
            '/BoxSettingsScreen',
          ),
        ),
      ],
    );
  }
}
