// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubscriptionModelAdapter extends TypeAdapter<SubscriptionModel> {
  @override
  final int typeId = 8;

  @override
  SubscriptionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubscriptionModel(
      gymId: fields[0] as String,
      subDate: fields[1] as Timestamp,
      endDate: fields[2] as Timestamp,
      uid: fields[3] as String,
      price: fields[4] as num,
      paymentMethod: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SubscriptionModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.gymId)
      ..writeByte(1)
      ..write(obj.subDate)
      ..writeByte(2)
      ..write(obj.endDate)
      ..writeByte(3)
      ..write(obj.uid)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.paymentMethod);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubscriptionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
