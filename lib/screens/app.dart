import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sole_capsule/widgets/general_widgets/padded_screen_widget.dart';

import '../provider/user_provider.dart';
import '../widgets/bottom_nav_widgets/bottom_nav_item.dart';
import 'bottom_nav_screens/home_screen.dart';
import 'bottom_nav_screens/shop_screen.dart';

class App extends StatefulWidget {
  static const rouetName = '/';

  const App({
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool isLoading = false;

  int currentScreen = 0;

  final pageController = PageController(initialPage: 0);

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void dispose() {
    super.dispose();

    pageController.dispose();
  }

  void changeScreen(int value) {
    setState(() {
      currentScreen = value;
    });
  }

  void changeToScreen(int screen) {
    pageController.jumpToPage(screen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: changeScreen,
              children: const [
                HomeSceen(),
                ShopScreen(),
                Center(
                  child: Text('PROFILE'),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: PaddedScreenWidget(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BottomNavItem(
                    icon: 'home.svg',
                    label: 'Home',
                    index: 0,
                    currentIndex: currentScreen,
                    function: changeToScreen,
                  ),
                  BottomNavItem(
                    icon: 'shop.svg',
                    label: 'Shop',
                    index: 1,
                    currentIndex: currentScreen,
                    function: changeToScreen,
                  ),
                  BottomNavItem(
                    icon: 'person_circle.svg',
                    label: 'Profile',
                    index: 2,
                    currentIndex: currentScreen,
                    function: changeToScreen,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getUserData() async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    setState(() {
      isLoading = true;
    });

    await userProvider.getUser(scaffoldKey: _scaffoldKey);

    setState(() {
      isLoading = false;
    });
  }
}
