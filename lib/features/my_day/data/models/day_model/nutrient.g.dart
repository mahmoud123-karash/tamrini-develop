// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrient.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NutrientAdapter extends TypeAdapter<Nutrient> {
  @override
  final int typeId = 4;

  @override
  Nutrient read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Nutrient(
      carbs: fields[0] as num,
      protein: fields[1] as num,
      fat: fields[2] as num,
      calories: fields[3] as num,
      grams: fields[4] as num,
    );
  }

  @override
  void write(BinaryWriter writer, Nutrient obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.carbs)
      ..writeByte(1)
      ..write(obj.protein)
      ..writeByte(2)
      ..write(obj.fat)
      ..writeByte(3)
      ..write(obj.calories)
      ..writeByte(4)
      ..write(obj.grams);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NutrientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
