// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plate_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlateModelAdapter extends TypeAdapter<PlateModel> {
  @override
  final int typeId = 2;

  @override
  PlateModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlateModel(
      name: fields[0] as String,
      price: fields[1] as double,
      description: fields[2] as String,
      image: fields[3] as String,
      category: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PlateModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlateModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
