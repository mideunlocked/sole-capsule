import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/theme_mode_provider.dart';
import '../../screens/box_screens/connect_wifi_screen.dart';

class ConnectWifiButton extends StatelessWidget {
  const ConnectWifiButton({
    super.key,
    required this.boxId,
  });

  final String boxId;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;

    var themePvr = Provider.of<ThemeModeProvider>(context, listen: false);
    bool isLightMode = themePvr.isLight;

    return SizedBox(
      height: 4.5.h,
      child: FloatingActionButton.extended(
        heroTag: 'connect',
        elevation: 0,
        backgroundColor: isLightMode
            ? const Color(0xFF000218).withOpacity(0.2)
            : const Color(0xFF101417),
        label: Text(
          'Connect Wi-Fi',
          style: textTheme.bodyMedium,
        ),
        onPressed: () => Navigator.pushNamed(
          context,
          ConnectWifiScreen.routeName,
          arguments: boxId,
        ),
      ),
    );
  }
}
