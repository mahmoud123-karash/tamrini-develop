import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/exercise_model.dart';

abstract class ExerciseRemoteDataSource {
  Future<List<ExerciseModel>> getExercises();
}

class ExerciseRemoteDataSourceImpl extends ExerciseRemoteDataSource {
  @override
  Future<List<ExerciseModel>> getExercises() async {
    List<ExerciseModel> exercices = [];
    var data = await FirebaseFirestore.instance
        .collection('exercises')
        .doc('data')
        .collection('data')
        .get();

    for (var element in data.docs) {
      ExerciseModel model = ExerciseModel.fromJson(element.data(), element.id);
      exercices.add(model);
    }

    return exercices;
  }
}
