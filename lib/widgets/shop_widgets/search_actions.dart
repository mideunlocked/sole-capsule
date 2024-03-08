import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/theme_mode_provider.dart';

class SearchActions extends StatelessWidget {
  const SearchActions({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final String icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Consumer<ThemeModeProvider>(builder: (context, tmPvr, child) {
        bool isLightMode = tmPvr.isLight;

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isLightMode ? null : const Color(0xFF14191D),
          ),
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
          child: Row(
            children: [
              Text(label),
              SizedBox(width: 1.h),
              SvgPicture.asset(
                'assets/icons/$icon.svg',
                // ignore: deprecated_member_use
                color: isLightMode ? null : Colors.white,
              ),
            ],
          ),
        );
      }),
    );
  }
}
