import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/general_widgets/padded_screen_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    var bodyLarge = textTheme.bodyLarge;
    var bodySmall = textTheme.bodySmall;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            PaddedScreenWidget(
              child: Column(
                children: [
                  SizedBox(height: 2.h),
                  const ProfileAppBar(),
                  SizedBox(height: 4.h),
                  Stack(
                    children: [
                      SizedBox(
                        height: 18.h,
                        width: 100.w,
                        child: CircleAvatar(
                          backgroundImage: const NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRudDbHeW2OobhX8E9fAY-ctpUAHeTNWfaqJA&usqp=CAU',
                          ),
                          radius: 50.sp,
                        ),
                      ),
                      IconButton(
                        color: Colors.black,
                        onPressed: () {},
                        icon: SvgPicture.asset('assets/icons/pen.svg'),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'John Doe',
                    style: bodyLarge,
                  ),
                  Text(
                    'johndoe@gmail.com',
                    style: bodySmall?.copyWith(
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 6.w),
                ],
              ),
            ),
            Container(
              width: 100.w,
              color: const Color(0xFFF2F2F2),
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
                vertical: 3.h,
              ),
              child: Column(
                children: [
                  const ProfileInfoTile(
                    label: 'Phone Number',
                    value: '+234 802 827 6612',
                  ),
                  SizedBox(height: 2.5.h),
                  const ProfileInfoTile(
                    label: 'Email',
                    value: 'johndoe@gmail.com',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileInfoTile extends StatelessWidget {
  const ProfileInfoTile({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    var bodySmall = textTheme.bodySmall;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: bodySmall?.copyWith(
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 1.h),
            Text(value),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'Edit',
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    var bodyLarge = textTheme.bodyLarge;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Shop',
          style: bodyLarge,
        ),
        SizedBox(
          height: 4.5.h,
          child: FloatingActionButton.extended(
            elevation: 0,
            backgroundColor: const Color(0xFFFFE4E4),
            label: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/logout.svg',
                ),
                SizedBox(width: 0.5.w),
                Text(
                  'Logout',
                  style: textTheme.bodySmall?.copyWith(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
