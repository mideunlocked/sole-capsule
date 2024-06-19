// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:wifi_scan/wifi_scan.dart';

class WifiProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<WiFiAccessPoint> _wifiList = [];
  List<WiFiAccessPoint> get wifiList => _wifiList;

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

  Future<void> startWifiScan() async {
    _loading();

    final can = await WiFiScan.instance.canStartScan(askPermissions: true);

    print(can);

    switch (can) {
      case CanStartScan.yes:
        await WiFiScan.instance.startScan();

        next();
        _loaded();
      default:
        _loaded();
    }
  }

  Future<void> getScannedWifi() async {
    final can =
        await WiFiScan.instance.canGetScannedResults(askPermissions: true);
    switch (can) {
      case CanGetScannedResults.yes:
        final accessPoints = await WiFiScan.instance.getScannedResults();

        if (accessPoints.isNotEmpty) {
          for (WiFiAccessPoint wAP in accessPoints) {
            _wifiList.add(wAP);
          }
        }

        _loaded();
        break;
      default:
        _loaded();
        break;
    }
  }
}
