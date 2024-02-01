import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'firebase_options.dart';
import 'helpers/routes.dart';
import 'provider/auth_provider.dart';
import 'provider/user_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  const MainApp({super.key});

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
        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            textTheme: TextTheme(
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
          initialRoute: '/SplashScreen',
          routes: routes,
        ),
      ),
    );
  }
}
