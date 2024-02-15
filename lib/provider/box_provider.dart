import 'package:flutter/material.dart';

import '../helpers/scaffold_messenger_helper.dart';
import '../models/box.dart';

class BoxProvider with ChangeNotifier {
  final List<Box> _boxes = [
    Box(
      id: '0',
      name: 'Nike Box',
      isOpen: false,
      isLightOn: false,
    ),
    Box(
      id: '1',
      name: 'Balenciaga Tripple S',
      isOpen: false,
      isLightOn: false,
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

  void toggleLight({
    required String id,
  }) {
    Box box = _boxes.firstWhere((box) => box.id == id);

    box.toggleLight();

    notifyListeners();
  }

  void toggleBoxOpen({
    required String id,
  }) {
    Box box = _boxes.firstWhere((box) => box.id == id);

    box.toggleBoxOpen();

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
