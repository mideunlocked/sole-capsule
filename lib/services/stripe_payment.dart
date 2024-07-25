// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:sole_capsule/helpers/scaffold_messenger_helper.dart';
import 'package:sole_capsule/models/delivery_details.dart';
import '../provider/theme_mode_provider.dart';

class StripePayment {
  static PaymentSheetAppearance _customizeAppearance(BuildContext context) {
    // get application current theme mode
    var theme = Theme.of(context);

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
    required BuildContext context,
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
        context: context,
      );
    }
  }

  static Future<bool> initializePayment({
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
    required DeliveryDetails deliveryDetails,
    required BuildContext context,
    required String currency,
    required int amount,
  }) async {
    try {
      // get application current theme mode

      var themeProvider =
          Provider.of<ThemeModeProvider>(context, listen: false);

      // 1. create payment intent on the server
      final data = await _createPaymentIntent(
        amount: amount,
        currency: currency,
        scaffoldKey: scaffoldKey,
        context: context,
      );

      // 2. initialize the payment sheet
      if (context.mounted) {
        PaymentSheetAppearance sheetAppearance;

        sheetAppearance = _customizeAppearance(context);

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
            appearance: sheetAppearance,
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
      }

      bool status = false;

      if (context.mounted) {
        status = await presentPayemntSheet(
          scaffoldKey: scaffoldKey,
          context: context,
        );
      }

      if (status == true) {
        return true;
      } else {
        if (context.mounted) {
          showScaffoldMessenger(
            scaffoldKey: scaffoldKey,
            textContent: 'Couldn\'t complete payment, please try again.',
            context: context,
          );
        }

        return false;
      }
    } catch (e) {
      print('Error: $e');
      if (context.mounted) {
        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent: 'Couldn\'t complete payment, please try again.',
          context: context,
        );
      }
      return false;
    }
  }

  static Future<bool> presentPayemntSheet({
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
    required BuildContext context,
  }) async {
    try {
      await Stripe.instance.presentPaymentSheet();

      return true;
    } catch (e) {
      if (context.mounted) {
        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent: 'Payment Failed, Please try again.',
          context: context,
        );
      }

      return false;
    }
  }
}
