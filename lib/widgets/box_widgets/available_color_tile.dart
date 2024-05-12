import 'package:flutter/material.dart';

class AvailableColorTile extends StatelessWidget {
  const AvailableColorTile({
    super.key,
    required this.color,
    required this.activeColor,
    required this.selectColor,
  });

  final Color color;
  final Color activeColor;
  final Function(Color) selectColor;

  @override
  Widget build(BuildContext context) {
    bool isCurrent = color == activeColor;

    return InkWell(
      onTap: () => selectColor(color),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isCurrent == true ? color : null,
          border: Border.all(
            color: color,
            width: 6,
          ),
        ),
      ),
    );
  }
}
