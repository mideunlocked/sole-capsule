import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/user_details.dart';
import '../../models/users.dart';
import '../../provider/theme_mode_provider.dart';
import '../../provider/user_provider.dart';
import '../../widgets/general_widgets/padded_screen_widget.dart';
import '../../widgets/profile_widgets/profile_app_bar.dart';
import '../../widgets/profile_widgets/profile_image.dart';
import '../../widgets/profile_widgets/profile_info_tile.dart';
import '../../widgets/profile_widgets/profile_route_list_tile.dart';
import '../profile_screens/orders_screen.dart';
import '../profile_screens/wallet_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    var bodyLarge = textTheme.bodyLarge;
    var bodySmall = textTheme.bodySmall;
    var listTileStyle = textTheme.bodyMedium;

    return Consumer<UserProvider>(builder: (context, user, child) {
      Users userData = user.user;
      UserDetails userDetails = userData.userDetails;
    
      return Column(
        children: [
          SizedBox(height: 2.h),
          const PaddedScreenWidget(
            child: ProfileAppBar(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PaddedScreenWidget(
                    child: Column(
                      children: [
                        // SizedBox(height: 2.h),
                        ProfileImage(
                          imageUrl: userDetails.profileImage,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          userDetails.fullName,
                          style: bodyLarge,
                        ),
                        Consumer<ThemeModeProvider>(
                            builder: (context, tmPvr, child) {
                          bool isLightMode = tmPvr.isLight;
            
                          return Text(
                            userDetails.email,
                            style: bodySmall?.copyWith(
                              color:
                                  isLightMode ? Colors.black54 : Colors.white54,
                            ),
                          );
                        }),
                        SizedBox(height: 6.w),
                      ],
                    ),
                  ),
                  Consumer<ThemeModeProvider>(
                    builder: (context, tmPvr, child) {
                      bool isLightMode = tmPvr.isLight;
            
                      return Container(
                        width: 100.w,
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: isLightMode
                              ? const Color(0xFFF2F2F2)
                              : const Color(0xFF14191D),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: child!,
                      );
                    },
                    child: Column(
                      children: [
                        ProfileInfoTile(
                          label: 'Phone Number',
                          value: userDetails.phoneNumber,
                        ),
                        SizedBox(height: 2.h),
                        ProfileInfoTile(
                          label: 'Email',
                          value: userDetails.email,
                        ),
                      ],
                    ),
                  ),
                  ProfileRouteListTile(
                    icon: 'wallet',
                    title: 'Wallet',
                    routeName: WalletScreen.routeName,
                    listTileStyle: listTileStyle,
                  ),ProfileRouteListTile(
                    icon: 'orders',
                    title: 'My Orders',
                    routeName: OrdersScreen.routeName,
                    listTileStyle: listTileStyle,
                  ),
                  ListTile(
                    title: Text(
                      'Dark Mode',
                      style: listTileStyle,
                    ),
                    trailing: Consumer<ThemeModeProvider>(
                        builder: (context, tmPvr, child) {
                      bool isLightMode = tmPvr.isLight;
            
                      return CupertinoSwitch(
                        value: !isLightMode,
                        onChanged: (value) => tmPvr.toggleThemeMode(),
                        activeColor: isLightMode ? Colors.black : Colors.white,
                        thumbColor: isLightMode ? Colors.white : Colors.black,
                        trackColor: isLightMode ? null : Colors.grey,
                      );
                    }),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 1.5.h,
                      horizontal: 5.w,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
