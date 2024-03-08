import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/theme_mode_provider.dart';

class OrdersTabTile extends StatelessWidget {
  const OrdersTabTile({
    super.key,
    required this.label,
    required this.tabIndex,
    required this.currentIndex,
    required this.toggleTab,
  });

  final String label;
  final int tabIndex;
  final int currentIndex;
  final Function(int) toggleTab;

  @override
  Widget build(BuildContext context) {
    bool isCurrent = tabIndex == currentIndex;

    return InkWell(
      onTap: () {
        toggleTab(tabIndex);
      },
      child: Consumer<ThemeModeProvider>(builder: (context, tmPvr, child) {
        bool isLightMode = tmPvr.isLight;

        Color lightColor = isCurrent ? Colors.black : Colors.black26;
        Color darkColor = isCurrent ? Colors.white : Colors.white54;

        Color color = isLightMode ? lightColor : darkColor;

        return Container(
          width: 50.w,
          height: 8.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: BorderDirectional(
              bottom: BorderSide(
                color: color,
                width: isCurrent ? 2 : 1,
              ),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: isCurrent ? FontWeight.w500 : null,
              color: color,
            ),
          ),
        );
      }),
    );
  }
}
