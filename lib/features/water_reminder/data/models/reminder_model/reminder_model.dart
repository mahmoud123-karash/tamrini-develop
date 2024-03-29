import 'package:hive/hive.dart';
part 'reminder_model.g.dart';

@HiveType(typeId: 5)
class ReminderModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String quantiy;
  @HiveField(2)
  final DateTime time;
  @HiveField(3)
  final bool isActive;

  ReminderModel({
    required this.id,
    required this.quantiy,
    required this.time,
    required this.isActive,
  });
}
