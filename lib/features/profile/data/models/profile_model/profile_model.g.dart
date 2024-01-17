// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileModelAdapter extends TypeAdapter<ProfileModel> {
  @override
  final int typeId = 1;

  @override
  ProfileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileModel(
      name: fields[10] as String,
      email: fields[11] as String,
      phone: fields[12] as String,
      facebookUri: fields[17] as String,
      instgramUri: fields[18] as String,
      twiterUri: fields[19] as String,
      address: fields[20] as String,
      gender: fields[14] as String,
      whatsApp: fields[21] as String?,
      image: fields[15] as String,
      age: fields[13] as int,
      isBanned: fields[16] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(10)
      ..write(obj.name)
      ..writeByte(11)
      ..write(obj.email)
      ..writeByte(12)
      ..write(obj.phone)
      ..writeByte(13)
      ..write(obj.age)
      ..writeByte(14)
      ..write(obj.gender)
      ..writeByte(15)
      ..write(obj.image)
      ..writeByte(16)
      ..write(obj.isBanned)
      ..writeByte(17)
      ..write(obj.facebookUri)
      ..writeByte(18)
      ..write(obj.instgramUri)
      ..writeByte(19)
      ..write(obj.twiterUri)
      ..writeByte(20)
      ..write(obj.address)
      ..writeByte(21)
      ..write(obj.whatsApp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
