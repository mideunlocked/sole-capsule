// ignore_for_file: avoid_print

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

  Future<void> checkBluetoothStatus({
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      if (await FlutterBluePlus.isSupported == false) {
        print("Bluetooth not supported by this device");
        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent: "Bluetooth not supported by this device",
        );
        return;
      }

      var subscription =
          FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
        print(state);
        if (state == BluetoothAdapterState.on) {
          _isOn = true;

          scanDevices(scaffoldKey: scaffoldKey);
        } else {
          _isOn = false;
          showScaffoldMessenger(
            scaffoldKey: scaffoldKey,
            textContent: "Error switching on bluetooth on device",
          );
        }
      });

      if (Platform.isAndroid) {
        await FlutterBluePlus.turnOn().then((value) => _isOn = true);

        scanDevices(scaffoldKey: scaffoldKey);
      }

      subscription.cancel();

      notifyListeners();
    } catch (e) {
      _isOn = false;
      showScaffoldMessenger(
        scaffoldKey: scaffoldKey,
        textContent: "Error switching on bluetooth on device",
      );

      notifyListeners();
    }
  }

  Future<void> scanDevices({
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      if (_isOn) {
        var subscription = FlutterBluePlus.onScanResults.listen(
          (results) {
            if (results.isNotEmpty) {
              for (ScanResult sr in results) {
                print(sr.device.advName);
                if (!_bleDevices.contains(sr)) {
                  _bleDevices.add(sr.device);

                  print('${sr.device.remoteId}: Name: ${sr.device.advName}');
                }
              }

              notifyListeners();
            }
          },
          onError: (e) => print(e),
        );

        FlutterBluePlus.cancelWhenScanComplete(subscription);

        await FlutterBluePlus.adapterState
            .where((val) => val == BluetoothAdapterState.on)
            .first;

        await FlutterBluePlus.startScan(
          withServices: [Guid("180D")], // match any of the specified services
          withNames: ["Sole Pod"], // *or* any of the specified names
          timeout: const Duration(seconds: 15),
        );

        // wait for scanning to stop
        await FlutterBluePlus.isScanning.where((val) => val == false).first;
      } else {
        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent:
              "Bluetooth is inactive, kindly switch on bluetooth on device",
        );
      }
    } catch (e) {
      print('Error scanning devices: $e');
      showScaffoldMessenger(
        scaffoldKey: scaffoldKey,
        textContent: "Error switching on bluetooth on device",
      );
    }
  }

  Future<void> connectToDevice({
    required BluetoothDevice device,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      if (_isOn) {
        var subscription = device.connectionState
            .listen((BluetoothConnectionState state) async {
          if (state == BluetoothConnectionState.disconnected) {
            print(
                "${device.disconnectReason?.code} ${device.disconnectReason?.description}");
          }
        });

        device.cancelWhenDisconnected(subscription, delayed: true, next: true);

        await device.connect().then((_) {
          _currentDevice = device;

          notifyListeners();
        });

        subscription.cancel();
      } else {
        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent:
              "Bluetooth is inactive, kindly switch on bluetooth on device",
        );
      }
    } catch (e) {
      print('Error connecting to device: $e');
      showScaffoldMessenger(
        scaffoldKey: scaffoldKey,
        textContent: "Error connecting to bluetooth device",
      );
    }
  }

  Future<void> disconnectDevice({
    required BluetoothDevice device,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      if (_isOn) {
        var subscription = device.connectionState
            .listen((BluetoothConnectionState state) async {
          if (state == BluetoothConnectionState.connected) {
            device.disconnect();
          }
        });

        subscription.cancel();
      } else {
        showScaffoldMessenger(
          scaffoldKey: scaffoldKey,
          textContent:
              "Bluetooth is inactive, kindly switch on bluetooth on device",
        );
      }
    } catch (e) {
      print('Error disconnecting device: $e');
      showScaffoldMessenger(
        scaffoldKey: scaffoldKey,
        textContent: "Error discoonecting bluetooth device",
      );
    }
  }
}
