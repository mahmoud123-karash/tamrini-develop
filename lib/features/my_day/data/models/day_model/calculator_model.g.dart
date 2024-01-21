// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculator_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalculatorModelAdapter extends TypeAdapter<CalculatorModel> {
  @override
  final int typeId = 3;

  @override
  CalculatorModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalculatorModel(
      calories: fields[0] as num,
      protein: fields[1] as num,
      fat: fields[2] as num,
      carbs: fields[3] as num,
    );
  }

  @override
  void write(BinaryWriter writer, CalculatorModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.calories)
      ..writeByte(1)
      ..write(obj.protein)
      ..writeByte(2)
      ..write(obj.fat)
      ..writeByte(3)
      ..write(obj.carbs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalculatorModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
