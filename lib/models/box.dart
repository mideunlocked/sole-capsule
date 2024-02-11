class Box {
  final String id;
  String name;
  bool isOpen;
  bool isLightOn;

  Box({
    required this.id,
    required this.name,
    required this.isOpen,
    required this.isLightOn,
  });

  factory Box.fromJson({
    required Map<String, dynamic> json,
  }) {
    return Box(
      id: json['id'] as String,
      name: json['name'] as String,
      isOpen: json['isOpen'] as bool,
      isLightOn: json['isLightOn'] as bool,
    );
  }

  Map<String, dynamic> toJson({required Box box}) {
    return {
      'id': box.id,
      'name': box.name,
      'isOpen': box.isOpen,
      'isLightOn': box.isLightOn,
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
}
