import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'firebase_options.dart';
import 'helpers/firebase_api.dart';
import 'helpers/routes.dart';
import 'helpers/save_share_preferences.dart';
import 'provider/auth_provider.dart';
import 'provider/box_provider.dart';
import 'provider/cart_provider.dart';
import 'provider/discount_provider.dart';
import 'provider/order_provider.dart';
import 'provider/product_provider.dart';
import 'provider/theme_mode_provider.dart';
import 'provider/user_provider.dart';
import 'screens/onboarding_screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate();

  await FirebaseApi().initNotification();

  await SaveSharedPref().initSharedPref();

  MainApp mainApp = const MainApp();

  runApp(mainApp);
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
  });

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => AuthProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => UserProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => BoxProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => ProductProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => CartProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => OrderProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => ThemeModeProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => DiscountProvider(),
          ),
        ],
        child: Consumer<ThemeModeProvider>(builder: (context, tmPvr, child) {
          tmPvr.setInitThemeMode();

          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: tmPvr.themeMode,
            initialRoute: SplashScreen.routeName,
            routes: routes,
          );
        }),
      ),
    );
  }
}
