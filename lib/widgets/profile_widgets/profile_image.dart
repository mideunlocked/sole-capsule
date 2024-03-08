import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/theme_mode_provider.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Hero(
          tag: 'Profile Image',
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              imageUrl,
            ),
            radius: 45.sp,
            backgroundColor: Colors.grey.shade300,
          ),
        ),
        Positioned(
          top: 45.sp,
          child: SizedBox(
            height: 8.h,
            width: 10.w,
            child:
                Consumer<ThemeModeProvider>(builder: (context, tmPvr, child) {
              bool isLightMode = tmPvr.isLight;

              return FloatingActionButton(
                heroTag: 'edit',
                elevation: 0,
                backgroundColor: isLightMode ? Colors.black : Colors.white,
                onPressed: () => Navigator.pushNamed(
                  context,
                  '/EditProfileScreen',
                ),
                child: SvgPicture.asset(
                  'assets/icons/pen.svg',
                  height: 3.h,
                  width: 3.h,
                  // ignore: deprecated_member_use
                  color: isLightMode ? null : Colors.black,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
