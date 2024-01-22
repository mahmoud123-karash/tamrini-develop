import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'reminder_model.g.dart';

@HiveType(typeId: 5)
class ReminderModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String quantiy;
  @HiveField(2)
  final TimeOfDay time;

  ReminderModel({
    required this.id,
    required this.quantiy,
    required this.time,
  });
}
