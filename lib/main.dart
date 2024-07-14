import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'firebase_options.dart';
import 'services/firebase_api.dart';
import 'helpers/routes.dart';
import 'services/hive_service.dart';
import 'services/save_share_preferences.dart';
import 'provider/auth_provider.dart';
import 'provider/ble_provider.dart';
import 'provider/box_provider.dart';
import 'provider/cart_provider.dart';
import 'provider/discount_provider.dart';
import 'provider/notification_provider.dart';
import 'provider/order_provider.dart';
import 'provider/product_provider.dart';
import 'provider/theme_mode_provider.dart';
import 'provider/user_provider.dart';
import 'provider/wifi_provider.dart';
import 'screens/onboarding_screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate();

  await FirebaseApi().initNotification();

  await SaveSharedPref().initSharedPref();

  await dotenv.load(fileName: 'assets/.env');
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLIC_KEY'] ?? '';
  await Stripe.instance.applySettings();

  await HiveService.initHive();

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
          ChangeNotifierProvider(create: (ctx) => AuthProvider()),
          ChangeNotifierProvider(create: (ctx) => UserProvider()),
          ChangeNotifierProvider(create: (ctx) => BoxProvider()),
          ChangeNotifierProvider(create: (ctx) => ProductProvider()),
          ChangeNotifierProvider(create: (ctx) => CartProvider()),
          ChangeNotifierProvider(create: (ctx) => OrderProvider()),
          ChangeNotifierProvider(create: (ctx) => ThemeModeProvider()),
          ChangeNotifierProvider(create: (ctx) => DiscountProvider()),
          ChangeNotifierProvider(create: (ctx) => NotificationProvider()),
          ChangeNotifierProvider(create: (ctx) => BleProvider()),
          ChangeNotifierProvider(create: (ctx) => WifiProvider()),
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
