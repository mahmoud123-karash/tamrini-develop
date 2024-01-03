import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/features/home/data/models/article_model/article_model.dart';
import 'package:tamrini/features/home/data/models/exercise_model/exercise_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<ExerciseModel>> getExercises();
  Future<List<ArticleModel>> getArticles();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
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

  @override
  Future<List<ArticleModel>> getArticles() async {
    List<ArticleModel> list = [];
    var result = await FirebaseFirestore.instance
        .collection('articles')
        .doc('data')
        .collection('articles')
        .orderBy('date', descending: true)
        .get();

    for (var element in result.docs) {
      ArticleModel model = ArticleModel.fromJson(element.data(), element.id);
      list.add(model);
    }
    return list;
  }
}
