class TraineeExerciseModel {
  final String exerciseId;
  final int setsNo;
  final int repeatNo;

  TraineeExerciseModel({
    required this.exerciseId,
    required this.setsNo,
    required this.repeatNo,
  });

  factory TraineeExerciseModel.fromJson(Map<String, dynamic> json) {
    return TraineeExerciseModel(
      exerciseId: json['exerciseId'],
      setsNo: json['setsNo'] ?? 0,
      repeatNo: json['repeatNo'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataModelDataModel = <String, dynamic>{};
    dataModelDataModel['exerciseId'] = exerciseId;
    dataModelDataModel['setsNo'] = setsNo;
    dataModelDataModel['repeatNo'] = repeatNo;
    return dataModelDataModel;
  }
}
