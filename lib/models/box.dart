class Box {
  final String id;
  final String name;
  final bool isOpen;
  final bool isLightOn;

  const Box({
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
}
