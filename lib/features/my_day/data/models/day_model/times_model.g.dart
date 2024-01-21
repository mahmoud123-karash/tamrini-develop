import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

class TimestampAdapter extends TypeAdapter<Timestamp> {
  @override
  final typeId = 100;

  @override
  Timestamp read(BinaryReader reader) {
    final seconds = reader.readInt32();
    final nanoseconds = reader.readInt32();
    return Timestamp(seconds, nanoseconds);
  }

  @override
  void write(BinaryWriter writer, Timestamp obj) {
    writer.writeInt32(obj.seconds);
    writer.writeInt32(obj.nanoseconds);
  }
}
