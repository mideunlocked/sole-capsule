import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/theme_mode_provider.dart';
import '../general_widgets/custom_icon.dart';

class ProfileRouteListTile extends StatelessWidget {
  const ProfileRouteListTile({
    super.key,
    required this.listTileStyle,
    required this.routeName,
    required this.icon,
    required this.title,
  });

  final TextStyle? listTileStyle;
  final String routeName;
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeProvider>(builder: (context, tmPvr, child) {
      bool isLightMode = tmPvr.isLight;

      return ListTile(
        leading: CustomIcon(icon: icon),
        title: Text(
          title,
          style: listTileStyle,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: isLightMode ? Colors.black : Colors.white,
        ),
        tileColor: isLightMode ? null : const Color(0xFF14191D),
        minLeadingWidth: 5.w,
        contentPadding: EdgeInsets.symmetric(
          vertical: 1.5.h,
          horizontal: 5.w,
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade200, width: 0.5),
        ),
        onTap: () => Navigator.pushNamed(
          context,
          '/$routeName',
        ),
      );
    });
  }
}
