import 'package:hive/hive.dart';

part 'box.g.dart';

@HiveType(typeId: 0)
class Box extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  bool isOpen;

  @HiveField(3)
  bool isLightOn;

  @HiveField(4)
  bool isConnected;

  @HiveField(5)
  double lightIntensity;

  @HiveField(6)
  int lightColor;

  @HiveField(7)
  String imagePath;

  @HiveField(8)
  String fontFamily;

  Box({
    required this.id,
    required this.name,
    required this.isOpen,
    required this.imagePath,
    required this.isLightOn,
    required this.fontFamily,
    required this.lightColor,
    required this.isConnected,
    required this.lightIntensity,
  });

  factory Box.fromJson({
    required Map<String, dynamic> json,
  }) {
    return Box(
      id: json['id'] as String,
      name: json['name'] as String,
      isOpen: json['isOpen'] as bool,
      imagePath: '',
      fontFamily: '',
      isLightOn: json['isLightOn'] as bool,
      lightColor: json['lightColor'] as int,
      isConnected: json['isConnected'] as bool,
      lightIntensity: json['lightIntensity'] as double,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'isOpen': isOpen,
  //     'isLightOn': isLightOn,
  //     'lightColor': lightColor,
  //     'isConnected': lightIntensity,
  //     'lightIntensity': lightIntensity,
  //   };
  // }

  void changeConnectionState(bool status) {
    isConnected = status;
  }

  void toggleLight() {
    isLightOn = !isLightOn;
  }

  void toggleBoxOpen() {
    isOpen = !isOpen;
  }

  void changeBoxName(String newName) {
    name = newName;
  }

  void changeLightColor(int newColor) {
    lightColor = newColor;
  }

  void changeLightIntensity(double newIntensity) {
    lightIntensity = newIntensity;
  }

  void updatePodImage(String newImagePath) {
    imagePath = newImagePath;
  }

  void updateTitleFont(String newFont) {
    fontFamily = newFont;
  }
}
