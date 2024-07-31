// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeliveryDetailsAdapter extends TypeAdapter<DeliveryDetails> {
  @override
  final int typeId = 3;

  @override
  DeliveryDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeliveryDetails(
      name: fields[0] as String,
      city: fields[1] as String,
      state: fields[2] as String,
      email: fields[3] as String,
      number: fields[4] as String,
      country: fields[5] as String,
      pinCode: fields[6] as String,
      address: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DeliveryDetails obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.state)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.number)
      ..writeByte(5)
      ..write(obj.country)
      ..writeByte(6)
      ..write(obj.pinCode)
      ..writeByte(7)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeliveryDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
