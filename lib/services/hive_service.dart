import 'package:hive_flutter/hive_flutter.dart';
import '../models/box.dart' as box;
import '../models/users.dart';

class HiveService {
  static const podskey = 'pods';
  static const userkey = 'user';

  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(box.BoxAdapter());
    Hive.registerAdapter(UsersAdapter());
  }

  static Future<Box<box.Box>> boxProperty() async {
    Box<box.Box> boxes = await Hive.openBox<box.Box>(podskey);

    return boxes;
  }

  static Future<Box<Users>> userProperty() async {
    Box<Users> user = await Hive.openBox<Users>(podskey);

    return user;
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

  static Future<void> addUser(Users newUser) async {
    Box user = await userProperty();

    user.add(newUser);
  }

  static Future<void> updateUser(Users updatedUser) async {
    Box user = await userProperty();

    user.putAt(0, updatedUser);
  }

  static Future<void> clearUser() async {
    Box user = await userProperty();

    user.clear();
  }
}
