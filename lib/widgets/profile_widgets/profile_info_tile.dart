import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/theme_mode_provider.dart';

class ProfileInfoTile extends StatelessWidget {
  const ProfileInfoTile({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    var bodySmall = textTheme.bodySmall;

    return Consumer<ThemeModeProvider>(builder: (context, tmPvr, child) {
      bool isLightMode = tmPvr.isLight;

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: bodySmall?.copyWith(
                  color: isLightMode ? Colors.black54 : Colors.white54,
                ),
              ),
              SizedBox(height: 1.h),
              Text(value),
            ],
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(
              context,
              '/EditProfileScreen',
            ),
            child: Text(
              'Edit',
              style: textTheme.bodyMedium?.copyWith(
                color: isLightMode ? Colors.black : Colors.white,
              ),
            ),
          ),
        ],
      );
    });
  }
}
