import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/app_contants.dart';

class SelectProfileImageWidget extends StatefulWidget {
  const SelectProfileImageWidget({
    super.key,
    this.imageUrl = '',
    required this.getProfileImage,
  });

  final String imageUrl;
  final Function(File) getProfileImage;

  @override
  State<SelectProfileImageWidget> createState() =>
      _SelectProfileImageWidgetState();
}

class _SelectProfileImageWidgetState extends State<SelectProfileImageWidget> {
  File file = File('');

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.circular(20);

    var backColor = Colors.grey.shade300;
    return InkWell(
      onTap: pickProfileImage,
      borderRadius: borderRadius,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(
            color: const Color(0xFFB7B7B7),
          ),
        ),
        child: Row(
          children: [
            widget.imageUrl.isNotEmpty
                ? CircleAvatar(
                    backgroundImage: NetworkImage(widget.imageUrl),
                    backgroundColor: backColor,
                    radius: 30.sp,
                  )
                : !file.isAbsolute
                    ? CircleAvatar(
                        radius: 25.sp,
                        backgroundColor: backColor,
                        child: SvgPicture.asset(AppConstants.personIcon),
                      )
                    : CircleAvatar(
                        backgroundColor: backColor,
                        backgroundImage: FileImage(
                          file,
                        ),
                        radius: 30.sp,
                      ),
            SizedBox(width: 3.w),
            Text(
              widget.imageUrl.isEmpty
                  ? 'Click to upload profile picture'
                  : 'Click to change profile picture',
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pickProfileImage() async {
    XFile? pickedImage;

    pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      if (pickedImage != null) {
        file = File(pickedImage.path);
        widget.getProfileImage(file);
      }
    });
  }
}
