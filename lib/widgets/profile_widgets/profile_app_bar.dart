// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/firebase_constants.dart';
import '../../provider/box_provider.dart';
import '../../provider/theme_mode_provider.dart';

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
          'Profile',
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
            onPressed: () => signOut(context),
          ),
        ),
      ],
    );
  }

  Future<void> signOut(BuildContext context) async {
    var thmPvr = Provider.of<ThemeModeProvider>(context, listen: false);
    var boxPvr = Provider.of<BoxProvider>(context, listen: false);

    await FirebaseConstants.authInstance.signOut().then((_) async {
      thmPvr.resetThemeMode();
      await boxPvr.clearPods();

      if (context.mounted) {
        await Navigator.pushNamedAndRemoveUntil(
            context, '/WelcomeScreen', (route) => false);
      }
    }).catchError((e) {
      print(e);
      return e;
    });
  }
}
