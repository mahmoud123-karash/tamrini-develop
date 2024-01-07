import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/features/exercise/data/models/home_exercise/home_exercise_model.dart';

abstract class ExerciseRemoteDataSource {
  Future<List<HomeExerciseModel>> get();
}

class ExerciseRemoteDataSourceImpl extends ExerciseRemoteDataSource {
  @override
  Future<List<HomeExerciseModel>> get() async {
    List<HomeExerciseModel> list = [];
    var result = await FirebaseFirestore.instance
        .collection('homeExercises')
        .doc('data')
        .collection('data')
        .get();

    for (var element in result.docs) {
      HomeExerciseModel model =
          HomeExerciseModel.fromJson(element.data(), element.id);

      list.add(model);
    }

    return list;
  }
}
