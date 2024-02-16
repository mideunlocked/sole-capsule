import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/firebase_constants.dart';
import '../../models/users.dart';
import '../../provider/user_provider.dart';
import '../../widgets/general_widgets/custom_icon.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    var bodyLarge = textTheme.bodyLarge;
    var bodySmall = textTheme.bodySmall;
    var listTileStyle = textTheme.bodyMedium;

    return SafeArea(
      child: Consumer<UserProvider>(builder: (context, user, child) {
        Users userData = user.user;

        return Column(
          children: [
            SizedBox(height: 2.h),
            const PaddedScreenWidget(
              child: ProfileAppBar(),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  PaddedScreenWidget(
                    child: Column(
                      children: [
                        SizedBox(height: 4.h),
                        ProfileImage(
                          imageUrl: userData.profileImage,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          userData.fullName,
                          style: bodyLarge,
                        ),
                        Text(
                          userData.email,
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
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F2F2),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        ProfileInfoTile(
                          label: 'Phone Number',
                          value: userData.phoneNumber,
                        ),
                        SizedBox(height: 2.h),
                        ProfileInfoTile(
                          label: 'Email',
                          value: userData.email,
                        ),
                      ],
                    ),
                  ),
                  ProfileRouteListTile(
                    icon: 'pin',
                    title: 'My Orders',
                    routeName: 'OrdersScreen',
                    listTileStyle: listTileStyle,
                  ),
                  ProfileRouteListTile(
                    icon: 'orders',
                    title: 'Delivery Address',
                    routeName: 'CheckOutDetailsScreen',
                    listTileStyle: listTileStyle,
                  ),
                  ListTile(
                    title: Text(
                      'Dark Mode',
                      style: listTileStyle,
                    ),
                    trailing: CupertinoSwitch(
                      value: false,
                      onChanged: (_) {},
                      trackColor: Colors.black26,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 1.5.h,
                      horizontal: 5.w,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class ProfileRouteListTile extends StatelessWidget {
  const ProfileRouteListTile({
    super.key,
    required this.listTileStyle,
    required this.routeName,
    required this.icon,
    required this.title,
  });

  final TextStyle? listTileStyle;
  final String routeName;
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomIcon(icon: icon),
      title: Text(
        title,
        style: listTileStyle,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.black,
      ),
      minLeadingWidth: 5.w,
      contentPadding: EdgeInsets.symmetric(
        vertical: 1.5.h,
        horizontal: 5.w,
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade200),
      ),
      onTap: () => Navigator.pushNamed(
        context,
        '/$routeName',
      ),
    );
  }
}

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
        CircleAvatar(
          backgroundImage: NetworkImage(
            imageUrl,
          ),
          radius: 45.sp,
        ),
        Positioned(
          top: 45.sp,
          child: SizedBox(
            height: 8.h,
            width: 10.w,
            child: FloatingActionButton(
              heroTag: 'edit',
              elevation: 0,
              backgroundColor: Colors.black,
              onPressed: () => Navigator.pushNamed(
                context,
                '/EditProfileScreen',
              ),
              child: SvgPicture.asset(
                'assets/icons/pen.svg',
                height: 3.h,
                width: 3.h,
              ),
            ),
          ),
        ),
      ],
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
          onPressed: () => Navigator.pushNamed(
            context,
            '/EditProfileScreen',
          ),
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
            heroTag: 'log-out',
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
            onPressed: () => FirebaseConstants.authInstance.signOut().then(
                  (value) => Navigator.pushReplacementNamed(
                          context, '/OnboardingScreen')
                      .catchError((e) {
                    print(e);
                    return e;
                  }),
                ),
          ),
        ),
      ],
    );
  }
}
