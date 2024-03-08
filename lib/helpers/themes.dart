import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppThemes {
  static ThemeData lightMode = ThemeData(
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
  );

  static ThemeData darkMode = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF0A0D0F),
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
        color: Colors.white,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
        fontSize: 35.sp,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 22.sp,
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 20.sp,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16.sp,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 11.sp,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 9.sp,
        color: Colors.white,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF000218),
    ),
    dividerColor: Colors.grey,
  );
}
