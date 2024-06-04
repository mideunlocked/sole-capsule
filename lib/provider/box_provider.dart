import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/scaffold_messenger_helper.dart';
import '../models/box.dart';
import 'ble_provider.dart';

class BoxProvider with ChangeNotifier {
  final List<Box> _boxes = [
    Box(
      id: '0',
      name: 'Nike Box',
      isOpen: false,
      isLightOn: false,
      lightIntensity: 50,
      isConnected: false,
      lightColor: Colors.orange,
    ),
    Box(
      id: '1',
      name: 'Balenciaga Tripple S',
      isOpen: false,
      isLightOn: false,
      lightIntensity: 50,
      isConnected: false,
      lightColor: Colors.white,
    ),
  ];

  List<Box> get boxes => [..._boxes];

  void addNewBox({required Box box}) {
    _boxes.add(box);

    notifyListeners();
  }

  Box getBox({
    required String id,
  }) {
    Box box = _boxes.firstWhere((box) => box.id == id);

    return box;
  }

  Future<void> toggleLight({
    required String id,
    required int status,
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    var blePvr = Provider.of<BleProvider>(context, listen: false);

    await blePvr
        .toggleLight(status: status, scaffoldKey: scaffoldKey)
        .then((_) {
      Box box = _boxes.firstWhere((box) => box.id == id);

      box.toggleLight();

      notifyListeners();
    });
  }

  Future<void> toggleBoxOpen({
    required String id,
    required int status,
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    var blePvr = Provider.of<BleProvider>(context, listen: false);

    await blePvr
        .toggleLight(status: status, scaffoldKey: scaffoldKey)
        .then((_) {
      Box box = _boxes.firstWhere((box) => box.id == id);

      box.toggleBoxOpen();

      notifyListeners();
    });
  }

  void changeIntensity({
    required String id,
    required double intensity,
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    var blePvr = Provider.of<BleProvider>(context, listen: false);

    await blePvr
        .toggleLight(status: intensity.toInt(), scaffoldKey: scaffoldKey)
        .then((_) {
      Box box = _boxes.firstWhere((box) => box.id == id);

      box.changeLightIntensity(intensity);

      notifyListeners();
    });
  }

  void changeLightColor({
    required String id,
    required Color color,
  }) {
    Box box = _boxes.firstWhere((box) => box.id == id);

    box.changeLightColor(color);

    notifyListeners();
  }

  void editBoxName(
      {required String id,
      required String newName,
      required GlobalKey<ScaffoldMessengerState> scaffoldKey}) {
    Box box = _boxes.firstWhere((box) => box.id == id);

    box.changeBoxName(newName);

    showScaffoldMessenger(
      scaffoldKey: scaffoldKey,
      textContent: 'Box name changed.',
      bkgColor: Colors.green,
    );

    notifyListeners();
  }

  void deleteBox({
    required String id,
  }) {
    _boxes.removeWhere((box) => box.id == id);

    notifyListeners();
  }
}
