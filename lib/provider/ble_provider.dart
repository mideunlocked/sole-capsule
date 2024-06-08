// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../helpers/scaffold_messenger_helper.dart';

class BleProvider with ChangeNotifier {
  final List<BluetoothDevice> _bleDevices = [];
  List<BluetoothDevice> get bleDevices => _bleDevices;

  bool _isOn = false;
  bool get isOn => _isOn;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  BluetoothDevice? _currentDevice;
  BluetoothDevice? get currentDevice => _currentDevice;

  BluetoothDevice? _selectedDevice;
  BluetoothDevice? get selectedDevice => _selectedDevice;

  List<BluetoothService> _services = [];

  StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;
  StreamSubscription<List<ScanResult>>? _scanSubscription;
  StreamSubscription<BluetoothConnectionState>? _connectionStateSubscription;

  @override
  void dispose() {
    _adapterStateSubscription?.cancel();
    _scanSubscription?.cancel();
    _connectionStateSubscription?.cancel();
    super.dispose();
  }

  void _loading() {
    _isLoading = true;
    notifyListeners();
  }

  void _loaded() {
    _isLoading = false;
    notifyListeners();
  }

  Future<void> checkBluetoothStatus({
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      if (await FlutterBluePlus.isSupported == false) {
        _showMessage(scaffoldKey, "Bluetooth not supported by this device");
        return;
      }

      _adapterStateSubscription =
          FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
        print(state);
        if (state == BluetoothAdapterState.on) {
          _isOn = true;
          scanDevices(scaffoldKey: scaffoldKey);
        } else {
          _isOn = false;
          _showMessage(scaffoldKey, "Error switching on Bluetooth on device");
        }
        notifyListeners();
      });

      if (Platform.isAndroid) {
        await FlutterBluePlus.turnOn().then((_) => _isOn = true);
        scanDevices(scaffoldKey: scaffoldKey);
      }
    } catch (e) {
      _isOn = false;
      _showMessage(scaffoldKey, "Error switching on Bluetooth on device");
      notifyListeners();
    }
  }

  Future<void> scanDevices({
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      if (_isOn) {
        _scanSubscription = FlutterBluePlus.onScanResults.listen((results) {
          for (ScanResult sr in results) {
            if (!_bleDevices
                .any((device) => device.remoteId == sr.device.remoteId)) {
              _bleDevices.add(sr.device);
              print('${sr.device.remoteId}: Name: ${sr.device.advName}');
            }
          }
          notifyListeners();
        }, onError: (e) {
          print('Error scanning devices: $e');
          _showMessage(scaffoldKey, "Error scanning devices");
        });

        await FlutterBluePlus.startScan(
          withServices: [Guid("180D")], // match any of the specified services
          withNames: ["Sole Pod"], // *or* any of the specified names
          timeout: const Duration(seconds: 15),
        );

        // wait for scanning to stop
        await FlutterBluePlus.isScanning.where((val) => val == false).first;
      } else {
        _showMessage(scaffoldKey,
            "Bluetooth is inactive, kindly switch on Bluetooth on device");
      }
    } catch (e) {
      print('Error scanning devices: $e');
      _showMessage(scaffoldKey, "Error scanning devices");
    }
  }

  Future<void> connectToDevice({
    required BuildContext context,
    required BluetoothDevice device,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    if (_selectedDevice == null) {
      try {
        _selectedDevice = device;
        _loading();

        if (_isOn) {
          _connectionStateSubscription =
              device.connectionState.listen((BluetoothConnectionState state) {
            if (state == BluetoothConnectionState.disconnected) {
              print(
                  "${device.disconnectReason?.code} ${device.disconnectReason?.description}");
            }
          });

          await device.connect().then((_) async {
            _currentDevice = device;

            _services = await device.discoverServices();

            if (context.mounted) Navigator.pop(context);
            _loaded();
            notifyListeners();
          }).catchError((e) {
            _selectedDevice = null;
            _loaded();
            print('Error connecting to device: $e');
            _showMessage(scaffoldKey, "Error connecting to Bluetooth device");
          });
        } else {
          _selectedDevice = null;
          _loaded();
          _showMessage(scaffoldKey,
              "Bluetooth is inactive, kindly switch on Bluetooth on device");
        }
      } catch (e) {
        _selectedDevice = null;
        _loaded();
        print('Error connecting to device: $e');
        _showMessage(scaffoldKey, "Error connecting to Bluetooth device");
      }
    }
  }

  Future<void> disconnectDevice({
    required BluetoothDevice device,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      if (_isOn) {
        await device.disconnect();
        _currentDevice = null;
        notifyListeners();
      } else {
        _showMessage(scaffoldKey,
            "Bluetooth is inactive, kindly switch on Bluetooth on device");
      }
    } catch (e) {
      print('Error disconnecting device: $e');
      _showMessage(scaffoldKey, "Error disconnecting Bluetooth device");
    }
  }

  void _showMessage(
      GlobalKey<ScaffoldMessengerState> scaffoldKey, String message,
      {Color? color}) {
    color != null
        ? showScaffoldMessenger(
            scaffoldKey: scaffoldKey, textContent: message, bkgColor: color)
        : showScaffoldMessenger(scaffoldKey: scaffoldKey, textContent: message);
  }

  Future<void> toggleLight({
    required int status,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    if (_currentDevice != null && _services.isNotEmpty) {
      try {
        for (BluetoothService service in _services) {
          for (BluetoothCharacteristic characteristic
              in service.characteristics) {
            if (characteristic.uuid ==
                Guid("6E400005-B5A3-F393-E0A9-E50E24DCCA9E")) {
              String value = status.toString();
              await characteristic.write(utf8.encode(value));
              print('Light toggled');
              break;
            }
          }
        }
      } catch (e) {
        print('Error toggling pod light: $e');
        _showMessage(scaffoldKey, "Error toggling pod light");
      }
    }
  }

  Future<void> toggleTray({
    required int status,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    if (_currentDevice != null && _services.isNotEmpty) {
      try {
        for (BluetoothService service in _services) {
          for (BluetoothCharacteristic characteristic
              in service.characteristics) {
            if (characteristic.uuid ==
                Guid("6E400002-B5A3-F393-E0A9-E50E24DCCA9E")) {
              String value = status.toString();
              await characteristic.write(utf8.encode(value));
              print('Pod tray toggled');
              break;
            }
          }
        }
      } catch (e) {
        print('Error toggling pod tray: $e');
        _showMessage(scaffoldKey, "Error toggling pod tray");
      }
    }
  }

  Future<void> toggleBrightness({
    required int status,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    if (_currentDevice != null && _services.isNotEmpty) {
      try {
        for (BluetoothService service in _services) {
          for (BluetoothCharacteristic characteristic
              in service.characteristics) {
            if (characteristic.uuid ==
                Guid("6E400006-B5A3-F393-E0A9-E50E24DCCA9E")) {
              String value = status.toString();
              await characteristic.write(utf8.encode(value));
              print('Pod brightness toggled');
              break;
            }
          }
        }
      } catch (e) {
        print('Error toggling pod brightness: $e');
        _showMessage(scaffoldKey, "Error toggling pod brightness");
      }
    }
  }

  Future<void> passWiFiCredToPod({
    required String networkId,
    required String password,
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    if (_currentDevice != null && _services.isNotEmpty) {
      try {
        for (BluetoothService service in _services) {
          for (BluetoothCharacteristic characteristic
              in service.characteristics) {
            if (characteristic.uuid ==
                Guid("6E400003-B5A3-F393-E0A9-E50E24DCCA9E")) {
              await characteristic.write(utf8.encode(networkId));
              print('Network Id passed');
            }
            if (characteristic.uuid ==
                Guid("6E400004-B5A3-F393-E0A9-E50E24DCCA9E")) {
              await characteristic.write(utf8.encode(password));
              print('Network password passed');
            }
          }
        }

        _showMessage(
          scaffoldKey,
          "Wi-Fi credentials passed to pod successfully",
          color: Colors.green,
        );

        Navigator.pop(context);
      } catch (e) {
        print('Error passing Wi-Fi credentials to pod: $e');
        _showMessage(scaffoldKey, "Error passing Wi-Fi credentials to pod");
      }
    }
  }
}
