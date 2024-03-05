import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'firebase_options.dart';
import 'helpers/firebase_api.dart';
import 'helpers/routes.dart';
import 'provider/auth_provider.dart';
import 'provider/box_provider.dart';
import 'provider/cart_provider.dart';
import 'provider/order_provider.dart';
import 'provider/product_provider.dart';
import 'provider/user_provider.dart';
import 'screens/onboarding_screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate();

  await FirebaseApi().initNotification();

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
        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.transparent,
              toolbarHeight: 10.h,
            ),
            textTheme: TextTheme(
              labelMedium: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
              titleLarge: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 35.sp,
                color: Colors.black,
              ),
              titleMedium: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 22.sp,
                color: Colors.black,
              ),
              titleSmall: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                color: Colors.black,
              ),
              bodyLarge: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16.sp,
                color: Colors.black,
              ),
              bodyMedium: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11.sp,
                color: Colors.black,
              ),
              bodySmall: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 9.sp,
                color: Colors.black,
              ),
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color(0xFF000218),
            ),
          ),
          initialRoute: SplashScreen.routeName,
          routes: routes,
        ),
      ),
    );
  }
}
