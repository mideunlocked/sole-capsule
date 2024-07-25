import 'package:hive_flutter/hive_flutter.dart';
import '../models/box.dart' as box;

class HiveService {
  static const podskey = 'pods';

  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(box.BoxAdapter());
  }

  static Future<Box<box.Box>> boxProperty() async {
    Box<box.Box> boxes = await Hive.openBox<box.Box>(podskey);

    return boxes;
  }

  static Future<void> addPod(box.Box pod) async {
    Box pods = await boxProperty();

    pods.add(pod);
  }

  static Future<void> updatePod(int index, box.Box pod) async {
    Box pods = await boxProperty();

    pods.putAt(index, pod);
  }

  static Future<void> deletePod(int index) async {
    Box pods = await boxProperty();

    pods.deleteAt(index);
  }

  static Future<void> clearPods() async {
    Box pods = await boxProperty();

    pods.clear();
  }
}
