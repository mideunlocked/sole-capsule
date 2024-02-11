import 'package:flutter/material.dart';

import '../screens/auth_screens/create_account_screen.dart';
import '../screens/auth_screens/forgot_password_screen.dart';
import '../screens/auth_screens/login_screen.dart';
import '../screens/auth_screens/reset_password_screen.dart';
import '../screens/auth_screens/set_up_screen.dart';
import '../screens/app.dart';
import '../screens/box_screens/box_screen.dart';
import '../screens/box_screens/box_settings_screen.dart';
import '../screens/cart_screens/cart_screen.dart';
import '../screens/checkout_screens/check_out_details_screen.dart';
import '../screens/checkout_screens/check_out_screen.dart';
import '../screens/box_screens/add_box_screen.dart';
import '../screens/checkout_screens/check_out_success_screen.dart';
import '../screens/onboarding_screens/onboarding_screen.dart';
import '../screens/onboarding_screens/splash_screen.dart';
import '../screens/onboarding_screens/welcome_screen.dart';
import '../screens/profile_screens/edit_profile_screen.dart';
import '../screens/profile_screens/orders_screen.dart';
import '../screens/shop_screens/product_screen.dart';

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
  EditProfileScreen.routeName: (ctx) => const EditProfileScreen(),
  BoxScreen.routeName: (ctx) => const BoxScreen(),
  BoxSettingsScreen.routeName: (ctx) => const BoxSettingsScreen(),
  CheckOutDetailsScreen.routeName: (ctx) => const CheckOutDetailsScreen(),
  CheckOutSuccessScreen.routeName: (ctx) => const CheckOutSuccessScreen(),
  ProductScreen.routeName: (ctx) => const ProductScreen(),
  OrdersScreen.routeName: (ctx) => const OrdersScreen(),
};
