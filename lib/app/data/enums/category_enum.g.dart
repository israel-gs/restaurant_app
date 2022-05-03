// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryEnumAdapter extends TypeAdapter<CategoryEnum> {
  @override
  final int typeId = 3;

  @override
  CategoryEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CategoryEnum.starterDish;
      case 1:
        return CategoryEnum.fish;
      case 2:
        return CategoryEnum.soups;
      case 3:
        return CategoryEnum.drinks;
      case 4:
        return CategoryEnum.desserts;
      default:
        return CategoryEnum.starterDish;
    }
  }

  @override
  void write(BinaryWriter writer, CategoryEnum obj) {
    switch (obj) {
      case CategoryEnum.starterDish:
        writer.writeByte(0);
        break;
      case CategoryEnum.fish:
        writer.writeByte(1);
        break;
      case CategoryEnum.soups:
        writer.writeByte(2);
        break;
      case CategoryEnum.drinks:
        writer.writeByte(3);
        break;
      case CategoryEnum.desserts:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
