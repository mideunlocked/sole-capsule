import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../widgets/general_widgets/custom_app_bar.dart';
import '../widgets/general_widgets/padded_screen_widget.dart';
import '../widgets/orders_widgets/orders_tab_tile.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = '/NotificationScreen';

  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int currentTab = 0;

  void toggleTab(int newTab) => setState(() => currentTab = newTab);

  @override
  Widget build(BuildContext context) {
    var textTheme2 = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PaddedScreenWidget(
              child: const CustomAppBar(
                title: 'Notifications',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OrdersTabTile(
                  label: 'ACCOUNT',
                  tabIndex: 0,
                  currentIndex: currentTab,
                  toggleTab: toggleTab,
                ),
                OrdersTabTile(
                  label: 'NEWS & UPDATES',
                  tabIndex: 1,
                  currentIndex: currentTab,
                  toggleTab: toggleTab,
                ),
              ],
            ),
            Expanded(
              child: PaddedScreenWidget(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    NotificationTile(textTheme2: textTheme2),
                    NotificationTile(textTheme2: textTheme2),
                    NotificationTile(textTheme2: textTheme2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.textTheme2,
  });

  final TextTheme textTheme2;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 1.h),
      leading: CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 0, 13, 54),
        backgroundImage: const AssetImage('assets/logo/sole.png'),
        radius: 15.sp,
      ),
      horizontalTitleGap: 4.w,
      title: Text(
        'SALE IS LIVE',
        style: textTheme2.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 13.sp,
        ),
      ),
      subtitle: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elitdolor sit amet, consectetur adipiscing elit.',
        style: textTheme2.bodySmall,
      ),
      trailing: Text(
        '1hr ago.',
        style: textTheme2.bodySmall,
      ),
    );
  }
}
