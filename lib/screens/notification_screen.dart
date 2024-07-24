import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../helpers/date_time_formatter.dart';
import '../models/notification.dart';
import '../provider/notification_provider.dart';
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

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, getNotifications);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldMessenger(
        key: _scaffoldKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PaddedScreenWidget(
              child: CustomAppBar(
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
                child: Consumer<NotificationProvider>(
                    builder: (context, notiPvr, _) {
                  return ListView(
                    padding: EdgeInsets.zero,
                    children: notiPvr.notifications
                        .map(
                          (e) => NotificationTile(
                            notification: e,
                          ),
                        )
                        .toList(),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getNotifications() async {
    var notificationProvider = Provider.of<NotificationProvider>(
      context,
      listen: false,
    );

    await notificationProvider.getNotifications(
      scaffoldKey: _scaffoldKey,
    );
  }
}

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.notification,
  });

  final Notifications notification;

  @override
  Widget build(BuildContext context) {
    var textTheme2 = Theme.of(context).textTheme;

    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 1.h),
      leading: notification.imageUrl.isEmpty
          ? CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 0, 13, 54),
              backgroundImage: const AssetImage('assets/logo/sole.png'),
              radius: 15.sp,
            )
          : CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 0, 13, 54),
              backgroundImage: NetworkImage(notification.imageUrl),
              radius: 15.sp,
            ),
      horizontalTitleGap: 4.w,
      title: Text(
        notification.title,
        style: textTheme2.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 13.sp,
        ),
      ),
      subtitle: Text(
        notification.description,
        style: textTheme2.bodySmall,
      ),
      trailing: Text(
        DateTimeFormatter.timeAgo(
          notification.timestamp.toDate(),
        ),
        style: textTheme2.bodySmall,
      ),
    );
  }
}
