import 'package:flutter/material.dart';

class Box {
  final String id;
  String name;
  bool isOpen;
  bool isLightOn;
  double lightIntensity;
  Color lightColor;

  Box({
    required this.id,
    required this.name,
    required this.isOpen,
    required this.isLightOn,
    required this.lightColor,
    required this.lightIntensity,
  });

  factory Box.fromJson({
    required Map<String, dynamic> json,
  }) {
    return Box(
      id: json['id'] as String,
      name: json['name'] as String,
      isOpen: json['isOpen'] as bool,
      isLightOn: json['isLightOn'] as bool,
      lightColor: json['lightColor'] as Color,
      lightIntensity: json['lightIntensity'] as double,
    );
  }

  Map<String, dynamic> toJson({required Box box}) {
    return {
      'id': box.id,
      'name': box.name,
      'isOpen': box.isOpen,
      'isLightOn': box.isLightOn,
      'lightColor': box.lightColor,
      'lightIntensity': box.lightIntensity,
    };
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

  void changeLightColor(Color newColor) {
    lightColor = newColor;
  }

  void changeLightIntensity(double newIntensity) {
    lightIntensity = newIntensity;
  }
}
