import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/home/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/home/data/models/exercise_model/exercise_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<ExerciseModel>> getExercises();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  @override
  Future<List<ExerciseModel>> getExercises() async {
    List<ExerciseModel> exercices = [];
    List<DataModel> exerciseData = [];
    var data = await FirebaseFirestore.instance
        .collection('exercises')
        .doc('data')
        .collection('data')
        .get();

    for (var element in data.docs) {
      ExerciseModel model = ExerciseModel.fromJson(element.data(), element.id);
      exercices.add(model);

      element.data()['data'].map((e) {
        DataModel model = DataModel.fromJson(e.data());
        exerciseData.add(model);
      });
    }

    saveLoaclData(exerciseData.take(5).toList());
    return exercices;
  }

  void saveLoaclData(List<DataModel> exercices) {
    var box = Hive.box<DataModel>(exerciseBox);
    box.addAll(exercices);
  }
}
