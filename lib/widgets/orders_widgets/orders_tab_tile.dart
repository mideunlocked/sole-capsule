import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
    Color color = isCurrent ? Colors.black : Colors.black26;

    return InkWell(
      onTap: () {
        toggleTab(tabIndex);
      },
      child: Container(
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
      ),
    );
  }
}
