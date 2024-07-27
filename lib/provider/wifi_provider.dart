// ignore_for_file: avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sole_capsule/helpers/scaffold_messenger_helper.dart';
import 'package:wifi_iot/wifi_iot.dart';

class WifiProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<WifiNetwork> _wifiList = [];
  List<WifiNetwork> get wifiList => _wifiList;

  int _currentStep = 0;
  int get currentStep => _currentStep;

  void _loading() {
    _isLoading = true;
    notifyListeners();
  }

  void _loaded() {
    _isLoading = false;
    notifyListeners();
  }

  void previous() {
    if (_currentStep > 0) {
      --_currentStep;
      notifyListeners();
    }
  }

  void next() {
    if (_currentStep < 3) {
      ++_currentStep;
      notifyListeners();
    }
  }

  void resetCurrentStep() {
    _currentStep = 0;
    notifyListeners();
  }

  Future<void> _requestPermissions() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      await Permission.location.request();
    }

    print('Location status: $status');
  }

  Future<void> loadWifiList({
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      await _requestPermissions();

      bool isConnected = await WiFiForIoTPlugin.isEnabled();

      print('Wifi is enabled: $isConnected');

      if (isConnected) {
        List<WifiNetwork> wifiNetworks = await WiFiForIoTPlugin.loadWifiList();

        _wifiList = wifiNetworks;

        print(_wifiList);
        notifyListeners();
      } else {
        if (context.mounted) {
          showScaffoldMessenger(
            scaffoldKey: scaffoldKey,
            context: context,
            textContent: 'Wifi not enabled for SOLE',
          );
        }
      }
    } catch (e) {
      print(e);
      if (context.mounted) {
        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          context: context,
          textContent: 'Wifi not enabled for SOLE',
        );
      }
    }
  }
}
