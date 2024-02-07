import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

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
      child: Row(
        children: [
          Text(label),
          SizedBox(width: 1.h),
          SvgPicture.asset('assets/icons/$icon.svg'),
        ],
      ),
    );
  }
}
