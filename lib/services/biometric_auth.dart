import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

enum SupportState {
  unknown,
  supported,
  unsupported,
}

class BiometricAuth {
  final LocalAuthentication _auth = LocalAuthentication();

  SupportState supportState = SupportState.unknown;

  List<BiometricType>? availableBiometrics;

  void initLocalAuth() {
    _auth.isDeviceSupported().then(
          (bool isSupported) => supportState =
              isSupported ? SupportState.supported : SupportState.unsupported,
        );
  }

  Future<bool> checkBiometric() async {
    bool canCheckBiometric = false;

    try {
      canCheckBiometric = await _auth.canCheckBiometrics;

      print('Can check biometric: $canCheckBiometric');
    } on PlatformException catch (e) {
      print(e);
      canCheckBiometric = false;
    }

    return canCheckBiometric;
  }

  Future<void> checkAvailableBiometrics() async {
    List<BiometricType> biometricsTypes = [];

    try {
      biometricsTypes = await _auth.getAvailableBiometrics();

      print('Available biometrics: $biometricsTypes');
    } on PlatformException catch (e) {
      print(e);
    }

    availableBiometrics = biometricsTypes;
  }

  Future<dynamic> authenticateWithBiometrics(
    BuildContext context, {
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      final authenticated = await _auth.authenticate(
        localizedReason: 'Scan biometrics',
        options: const AuthenticationOptions(
          biometricOnly: true,
          sensitiveTransaction: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );

      return authenticated;
    } on PlatformException catch (_) {
      return false;
    }
  }
}
