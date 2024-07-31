// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import '../helpers/scaffold_messenger_helper.dart';
import '../screens/app.dart';
import '../services/biometric_auth.dart';
import '../services/save_share_preferences.dart';

class BiometricsProvider with ChangeNotifier {
  final BiometricAuth _biometricAuth = BiometricAuth();

  SupportState _supportState = SupportState.unknown;
  SupportState get supportState => _supportState;

  bool _canAuthenticateWithBio = false;
  bool get canAuthenticateWithBio => _canAuthenticateWithBio;

  List<BiometricType>? _biometricsTypes = [];
  List<BiometricType>? get biometricsTypes => _biometricsTypes;

  bool _bioEnabled = false;
  bool get bioEnabled => _bioEnabled;

  void checkLocalAuthSupported() {
    _biometricAuth.initLocalAuth();

    _supportState = _biometricAuth.supportState;
    notifyListeners();
  }

  Future<void> checkBiometric() async {
    _canAuthenticateWithBio = await _biometricAuth.checkBiometric();

    notifyListeners();
  }

  Future<void> checkAvailableBiometrics() async {
    await _biometricAuth.checkAvailableBiometrics();

    _biometricsTypes = _biometricAuth.availableBiometrics;

    notifyListeners();
  }

  Future<void> setBioAuthStatus() async {
    await SaveSharedPref.setBioAuth(!_bioEnabled).then((_) {
      _bioEnabled = !_bioEnabled;
    });

    notifyListeners();
  }

  Future<void> getBioStatus() async {
    bool status = await SaveSharedPref.getBioAuth();

    _bioEnabled = status;

    notifyListeners();
  }

  Future<void> authenticateWithBiometrics({
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    bool authenticated = await _biometricAuth.authenticateWithBiometrics(
      context,
      scaffoldKey: scaffoldKey,
    );

    print(authenticated);

    if (authenticated) {
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          App.rouetName,
          (_) => false,
        );
      }
    } else {
      if (context.mounted) {
        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          context: context,
          textContent: 'Authentication failed',
        );
      }
    }
  }
}
