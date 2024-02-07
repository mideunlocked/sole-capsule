import 'package:flutter/material.dart';

import '../screens/auth_screens/create_account_screen.dart';
import '../screens/auth_screens/forgot_password_screen.dart';
import '../screens/auth_screens/login_screen.dart';
import '../screens/auth_screens/reset_password_screen.dart';
import '../screens/auth_screens/set_up_screen.dart';
import '../screens/app.dart';
import '../screens/cart_screens/cart_screen.dart';
import '../screens/check_out_screen.dart';
import '../screens/home_screens/add_box_screen.dart';
import '../screens/onboarding_screens/onboarding_screen.dart';
import '../screens/onboarding_screens/splash_screen.dart';
import '../screens/onboarding_screens/welcome_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  App.rouetName: (ctx) => const App(),
  SplashScreen.routeName: (ctx) => const SplashScreen(),
  OnboardingScreen.routeName: (ctx) => const OnboardingScreen(),
  WelcomeScreen.routeName: (ctx) => const WelcomeScreen(),
  CreateAccountScreen.routeName: (ctx) => const CreateAccountScreen(),
  SetUpScreen.routeName: (ctx) => const SetUpScreen(),
  LoginScreen.routeName: (ctx) => const LoginScreen(),
  ForgotPasswordScreen.routeName: (ctx) => const ForgotPasswordScreen(),
  ResetPasswordScreen.routeName: (ctx) => const ResetPasswordScreen(),
  AddBoxScreen.routeName: (ctx) => const AddBoxScreen(),
  CheckOutScreen.routeName: (ctx) => const CheckOutScreen(),
  CartScreen.routeName: (ctx) => const CartScreen(),
};
