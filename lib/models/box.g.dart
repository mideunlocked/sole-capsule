// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BoxAdapter extends TypeAdapter<Box> {
  @override
  final int typeId = 0;

  @override
  Box read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Box(
      id: fields[0] as String,
      name: fields[1] as String,
      isOpen: fields[2] as bool,
      imagePath: fields[7] as String,
      isLightOn: fields[3] as bool,
      lightColor: fields[6] as int,
      isConnected: fields[4] as bool,
      lightIntensity: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Box obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.isOpen)
      ..writeByte(3)
      ..write(obj.isLightOn)
      ..writeByte(4)
      ..write(obj.isConnected)
      ..writeByte(5)
      ..write(obj.lightIntensity)
      ..writeByte(6)
      ..write(obj.lightColor)
      ..writeByte(7)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
