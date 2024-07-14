import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart' as hive;

import '../helpers/scaffold_messenger_helper.dart';
import '../models/box.dart';
import '../services/hive_service.dart';
import 'ble_provider.dart';

class BoxProvider with ChangeNotifier {
  final List<Box> _boxes = [
    // Box(
    //   id: '0',
    //   name: 'Nike Box',
    //   isOpen: false,
    //   isLightOn: false,
    //   lightIntensity: 50,
    //   isConnected: false,
    //   lightColor: Colors.orange.value,
    // ),
    // Box(
    //   id: '1',
    //   name: 'Balenciaga Tripple S',
    //   isOpen: false,
    //   isLightOn: false,
    //   lightIntensity: 50,
    //   isConnected: false,
    //   lightColor: Colors.white.value,
    // ),
  ];

  List<Box> get boxes => [..._boxes];

  Future<void> getBoxes() async {
    _boxes.clear();
    hive.Box<Box> boxes = await HiveService.boxProperty();

    for (Box b in boxes.values) {
      _boxes.add(b);
    }

    notifyListeners();
  }

  void addNewBox({required Box box}) async {
    await HiveService.addPod(box);

    await getBoxes();
  }

  Future<void> updateBox({required String id}) async {
    Box box = _boxes.firstWhere((box) => box.id == id);
    int index = _boxes.indexWhere((e) => e.id == box.id);

    await HiveService.updatePod(index, box);

    await getBoxes();
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

    await updateBox(id: id);
  }

  Future<void> toggleBoxOpen({
    required String id,
    required int status,
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    var blePvr = Provider.of<BleProvider>(context, listen: false);

    await blePvr.toggleTray(status: status, scaffoldKey: scaffoldKey).then((_) {
      Box box = _boxes.firstWhere((box) => box.id == id);

      box.toggleBoxOpen();

      notifyListeners();
    });

    await updateBox(id: id);
  }

  Future<void> changeIntensity({
    required String id,
    required double intensity,
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    var blePvr = Provider.of<BleProvider>(context, listen: false);

    double brightness = intensity / 100 * 255;

    await blePvr
        .toggleBrightness(status: brightness.toInt(), scaffoldKey: scaffoldKey)
        .then((_) {
      Box box = _boxes.firstWhere((box) => box.id == id);

      box.changeLightIntensity(intensity);

      notifyListeners();
    });

    await updateBox(id: id);
  }

  Future<void> passWiFiCredToPod({
    required String id,
    required String networkId,
    required String password,
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    Box box = _boxes.firstWhere((box) => box.id == id);

    if (box.isConnected) {
      var blePvr = Provider.of<BleProvider>(context, listen: false);

      await blePvr.passWiFiCredToPod(
        networkId: networkId,
        password: password,
        context: context,
        scaffoldKey: scaffoldKey,
      );

      return;
    }

    showScaffoldMessenger(
      scaffoldKey: scaffoldKey,
      textContent:
          'Pod must be connected to device via bluetooth before Wi-Fi Credentials can be passed',
    );

    await updateBox(id: id);
  }

  Future<void> changeLightColor({
    required String id,
    required Color color,
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    var blePvr = Provider.of<BleProvider>(context, listen: false);

    String r = color.red.toString();
    String g = color.green.toString();
    String b = color.blue.toString();

    await blePvr
        .passLightColorParam(
            r: r, g: g, b: b, context: context, scaffoldKey: scaffoldKey)
        .then((_) {
      Box box = _boxes.firstWhere((box) => box.id == id);

      box.changeLightColor(color.value);
    });

    notifyListeners();
    await updateBox(id: id);
  }

  void editBoxName(
      {required String id,
      required String newName,
      required GlobalKey<ScaffoldMessengerState> scaffoldKey}) async {
    Box box = _boxes.firstWhere((box) => box.id == id);

    box.changeBoxName(newName);

    showScaffoldMessenger(
      scaffoldKey: scaffoldKey,
      textContent: 'Box name changed.',
      bkgColor: Colors.green,
    );

    notifyListeners();
    await updateBox(id: id);
  }

  void deleteBox({
    required String id,
  }) async {
    int index = _boxes.indexWhere((e) => e.id == id);

    HiveService.deletePod(index);

    await updateBox(id: id);

    notifyListeners();
  }
}
