// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../helpers/scaffold_messenger_helper.dart';

class BleProvider with ChangeNotifier {
  final List<BluetoothDevice> _bleDevices = [];
  List<BluetoothDevice> get bleDevices => _bleDevices;

  bool _isOn = false;
  bool get isOn => _isOn;

  BluetoothDevice? _currentDevice;
  BluetoothDevice? get currentDevice => _currentDevice;

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
    required BluetoothDevice device,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      if (_isOn) {
        _connectionStateSubscription =
            device.connectionState.listen((BluetoothConnectionState state) {
          if (state == BluetoothConnectionState.disconnected) {
            print(
                "${device.disconnectReason?.code} ${device.disconnectReason?.description}");
          }
        });

        await device.connect().then((_) {
          _currentDevice = device;
          notifyListeners();
        }).catchError((e) {
          print('Error connecting to device: $e');
          _showMessage(scaffoldKey, "Error connecting to Bluetooth device");
        });
      } else {
        _showMessage(scaffoldKey,
            "Bluetooth is inactive, kindly switch on Bluetooth on device");
      }
    } catch (e) {
      print('Error connecting to device: $e');
      _showMessage(scaffoldKey, "Error connecting to Bluetooth device");
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
      GlobalKey<ScaffoldMessengerState> scaffoldKey, String message) {
    showScaffoldMessenger(scaffoldKey: scaffoldKey, textContent: message);
  }
}
