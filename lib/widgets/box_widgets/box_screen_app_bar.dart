import 'package:flutter/material.dart';

import '../general_widgets/custom_back_button.dart';
import '../general_widgets/custom_icon_button.dart';

class BoxAppBar extends StatelessWidget {
  const BoxAppBar({
    super.key,
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CustomBackButton(
        ),
        CustomIconButton(
          icon: 'settings',
          onTap: () => Navigator.pushNamed(
            context,
            '/BoxSettingsScreen',
            arguments: {
              'id': id,
              'name': name,
            },
          ),
        ),
      ],
    );
  }
}
