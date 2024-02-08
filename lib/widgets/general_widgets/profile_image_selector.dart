import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/app_contants.dart';

class SelectProfileImageWidget extends StatelessWidget {
  const SelectProfileImageWidget({
    super.key,
    this.imageUrl = '',
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFB7B7B7),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.sp,
            backgroundColor: Colors.grey.shade300,
            child: imageUrl.isEmpty
                ? SvgPicture.asset(AppConstants.personIcon)
                : CircleAvatar(
                    backgroundImage: NetworkImage(
                      imageUrl,
                    ),
                    radius: 50.sp,
                  ),
          ),
          SizedBox(width: 3.w),
          Text(
            imageUrl.isEmpty
                ? 'Click to upload profile picture'
                : 'Click to change profile picture',
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
