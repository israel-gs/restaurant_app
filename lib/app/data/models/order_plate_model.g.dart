// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_plate_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderPlateModelAdapter extends TypeAdapter<OrderPlateModel> {
  @override
  final int typeId = 5;

  @override
  OrderPlateModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderPlateModel(
      plate: fields[0] as PlateModel,
      quantity: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, OrderPlateModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.plate)
      ..writeByte(1)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderPlateModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
