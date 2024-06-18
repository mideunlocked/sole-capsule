import 'package:flutter/material.dart';
import 'package:wifi_scan/wifi_scan.dart';

class WifiProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<WiFiAccessPoint> _wifiList = [];
  List<WiFiAccessPoint> get wifiList => _wifiList;

  void _loading() {
    _isLoading = true;
    notifyListeners();
  }

  void _loaded() {
    _isLoading = false;
    notifyListeners();
  }

  Future<void> startWifiScan(
    ScrollController scrollCtr,
  ) async {
    _loading();

    final can = await WiFiScan.instance.canStartScan(askPermissions: true);

    print(can);

    switch (can) {
      case CanStartScan.yes:
        final result = await WiFiScan.instance.startScan();

        print(result);
        _loaded();
      default:
        _loaded();
    }

    scrollCtr.jumpTo(1);
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
