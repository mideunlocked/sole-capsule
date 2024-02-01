import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class AddBoxTile extends StatelessWidget {
  const AddBoxTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.circular(20);

    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        '/AddBoxScreen',
      ),
      borderRadius: borderRadius,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: const Color(0xFF000000),
        ),
        alignment: Alignment.center,
        child: CircleAvatar(
          maxRadius: 22.sp,
          backgroundColor: Colors.white,
          child: SvgPicture.asset(
            'assets/icons/add.svg',
          ),
        ),
      ),
    );
  }
}
