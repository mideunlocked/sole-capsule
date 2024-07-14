// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:sole_capsule/helpers/scaffold_messenger_helper.dart';
import 'package:sole_capsule/models/delivery_details.dart';
import '../main.dart';
import '../provider/theme_mode_provider.dart';

class StripePayment {
  static PaymentSheetAppearance _customizeAppearance() {
    // get application current theme mode
    final context = MainApp.navigatorKey.currentState?.overlay?.context;

    var theme = Theme.of(context!);

    PaymentSheetAppearance appearance = PaymentSheetAppearance(
      colors: PaymentSheetAppearanceColors(
        background: theme.scaffoldBackgroundColor,
        primary: theme.primaryColor,
        componentBorder: Colors.grey,
        primaryText: theme.textTheme.bodyMedium?.color,
        secondaryText: theme.textTheme.bodyMedium?.color,
        icon: theme.textTheme.bodyMedium?.color,
      ),
      shapes: const PaymentSheetShape(
        borderWidth: 4,
        borderRadius: 20,
        shadow: PaymentSheetShadowParams(color: Colors.grey),
      ),
      primaryButton: const PaymentSheetPrimaryButtonAppearance(
        shapes: PaymentSheetPrimaryButtonShape(blurRadius: 8),
        colors: PaymentSheetPrimaryButtonTheme(
          dark: PaymentSheetPrimaryButtonThemeColors(
            background: Color(0xFF101417),
            text: Colors.white,
            border: Colors.transparent,
          ),
          light: PaymentSheetPrimaryButtonThemeColors(
            background: Color(0xFF000218),
            text: Colors.black,
            border: Colors.transparent,
          ),
        ),
      ),
    );

    return appearance;
  }

  static Future _createPaymentIntent({
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
    required String currency,
    required int amount,
  }) async {
    final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
    final secretKey = dotenv.env['STRIPE_SECRET_KEY'];

    final body = {
      'amount': '${amount}00',
      'currency': currency.toLowerCase(),
      'automatic_payment_methods[enabled]': 'true',
    };

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $secretKey',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      return jsonBody;
    } else {
      showScaffoldMessenger(
        scaffoldKey: scaffoldKey,
        textContent: 'Error initializing payment intent',
      );
    }
  }

  static Future<bool> initializePayment({
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
    required DeliveryDetails deliveryDetails,
    required String currency,
    required int amount,
  }) async {
    try {
      // get application current theme mode
      final context = MainApp.navigatorKey.currentState?.overlay?.context;

      var themeProvider =
          Provider.of<ThemeModeProvider>(context!, listen: false);

      // 1. create payment intent on the server
      final data = await _createPaymentIntent(
        amount: amount,
        currency: currency,
        scaffoldKey: scaffoldKey,
      );

      // 2. initialize the payment sheet

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Set to true for custom flow
          customFlow: false,
          // Main params
          merchantDisplayName: 'Sole Capsule LTD',
          paymentIntentClientSecret: data['client_secret'] as String,
          // Customer keys
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['id'] as String,
          style: themeProvider.isLight ? ThemeMode.light : ThemeMode.dark,
          appearance: _customizeAppearance(),
          billingDetails: BillingDetails(
            email: 'osuolaleariyo@gmail.com',
            name: 'Ariyo Osuolale',
            phone: deliveryDetails.number,
            address: Address(
              city: deliveryDetails.city,
              country: deliveryDetails.country,
              line1: deliveryDetails.address,
              line2: '',
              postalCode: deliveryDetails.pinCode,
              state: deliveryDetails.state,
            ),
          ),
        ),
      );

      bool status = await presentPayemntSheet(scaffoldKey: scaffoldKey);

      if (status == true) {
        return true;
      } else {
        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent: 'Couldn\'t complete payment, please try again.',
        );

        return false;
      }
    } catch (e) {
      print('Error: $e');
      showScaffoldMessenger(
        scaffoldKey: scaffoldKey,
        textContent: 'Couldn\'t complete payment, please try again.',
      );
      return false;
    }
  }

  static Future<bool> presentPayemntSheet({
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      await Stripe.instance.presentPaymentSheet();

      return true;
    } catch (e) {
      showScaffoldMessenger(
        scaffoldKey: scaffoldKey,
        textContent: 'Payment Failed, Please try again.',
      );

      return false;
    }
  }
}
