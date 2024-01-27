import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'helpers/routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: TextTheme(
            titleMedium: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 22.sp,
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
    );
  }
}
