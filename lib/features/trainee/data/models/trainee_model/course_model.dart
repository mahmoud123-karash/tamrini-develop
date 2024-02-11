import 'package:cloud_firestore/cloud_firestore.dart';

import 'trainee_exercises_model.dart';

class CourseModel {
  final DayWeekExercises dayWeekExercises;
  final String duration;
  final String notes;
  final String title;
  final Timestamp createdAt;

  CourseModel({
    required this.dayWeekExercises,
    required this.duration,
    required this.notes,
    required this.title,
    required this.createdAt,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    DayWeekExercises dayWeekExercises = DayWeekExercises();
    if (json['followUpData'] != null) {
      dayWeekExercises = DayWeekExercises.fromJson(json['dayWeekExercises']);
    }
    return CourseModel(
      dayWeekExercises: dayWeekExercises,
      duration: json['duration'] ?? '',
      notes: json['notes'] ?? '',
      title: json['title'] ?? '',
      createdAt: json['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dayWeekExercises'] = dayWeekExercises.toJson();
    data['duration'] = duration;
    data['notes'] = notes;
    data['title'] = title;
    data['createdAt'] = createdAt;
    return data;
  }
}

class DayWeekExercises {
  List<TraineeExerciseModel>? sat = [];
  List<TraineeExerciseModel>? sun = [];
  List<TraineeExerciseModel>? mon = [];
  List<TraineeExerciseModel>? tue = [];
  List<TraineeExerciseModel>? wed = [];
  List<TraineeExerciseModel>? thurs = [];
  List<TraineeExerciseModel>? fri = [];

  DayWeekExercises({
    this.sat,
    this.sun,
    this.mon,
    this.tue,
    this.wed,
    this.thurs,
    this.fri,
  });

  DayWeekExercises.fromJson(Map<String, dynamic> json) {
    sat = json['sat'] != null
        ? (json['sat'] as List)
            .map((i) => TraineeExerciseModel.fromJson(i))
            .toList()
        : [];
    sun = json['sun'] != null
        ? (json['sun'] as List)
            .map((i) => TraineeExerciseModel.fromJson(i))
            .toList()
        : [];
    mon = json['mon'] != null
        ? (json['mon'] as List)
            .map((i) => TraineeExerciseModel.fromJson(i))
            .toList()
        : [];
    tue = json['tue'] != null
        ? (json['tue'] as List)
            .map((i) => TraineeExerciseModel.fromJson(i))
            .toList()
        : [];
    wed = json['wed'] != null
        ? (json['wed'] as List)
            .map((i) => TraineeExerciseModel.fromJson(i))
            .toList()
        : [];
    thurs = json['thurs'] != null
        ? (json['thurs'] as List)
            .map((i) => TraineeExerciseModel.fromJson(i))
            .toList()
        : [];
    fri = json['fri'] != null
        ? (json['fri'] as List)
            .map((i) => TraineeExerciseModel.fromJson(i))
            .toList()
        : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sat'] = sat?.map((e) => e.toJson()).toList();
    data['sun'] = sun?.map((e) => e.toJson()).toList();
    data['mon'] = mon?.map((e) => e.toJson()).toList();
    data['tue'] = tue?.map((e) => e.toJson()).toList();
    data['wed'] = wed?.map((e) => e.toJson()).toList();
    data['thurs'] = thurs?.map((e) => e.toJson()).toList();
    data['fri'] = fri?.map((e) => e.toJson()).toList();
    return data;
  }
}
