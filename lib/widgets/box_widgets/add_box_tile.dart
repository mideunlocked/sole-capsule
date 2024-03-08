import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/theme_mode_provider.dart';

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
      child: Consumer<ThemeModeProvider>(builder: (context, tmPvr, child) {
        bool isLightMode = tmPvr.isLight;

        return Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color:
                isLightMode ? const Color(0xFF000000) : const Color(0xFF14191D),
          ),
          alignment: Alignment.center,
          child: CircleAvatar(
            maxRadius: 22.sp,
            backgroundColor: Colors.white,
            child: SvgPicture.asset(
              'assets/icons/add.svg',
            ),
          ),
        );
      }),
    );
  }
}
