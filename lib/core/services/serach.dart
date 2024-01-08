import 'package:fuzzy/fuzzy.dart';
import 'package:tamrini/features/exercise/data/models/home_exercise/exercise_model.dart';
import 'package:tamrini/features/home/data/models/article_model/article_model.dart';
import 'package:tamrini/features/home/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/home/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/home/data/models/store_model/product_model.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';

List<DataModel> searchExercise(value, List<DataModel> data) {
  final options = [for (var element in data) element.title!];
  final fuse = Fuzzy(options);
  final results = fuse.search(value).map((result) => result.item).toList();
  return data.where((element) => results.contains(element.title)).toList();
}

List<ArticleModel> searchArticles(value, List<ArticleModel> data) {
  final options = [for (var element in data) element.title!];
  final fuse = Fuzzy(options);
  final results = fuse.search(value).map((result) => result.item).toList();
  return data.where((element) => results.contains(element.title)).toList();
}

List<GymModel> searchGym(value, List<GymModel> data) {
  final options = [for (var element in data) element.name];
  final fuse = Fuzzy(options);
  final results = fuse.search(value).map((result) => result.item).toList();
  return data.where((element) => results.contains(element.name)).toList();
}

List<ProductModel> searchProduct(value, List<ProductModel> data) {
  final options = [for (var element in data) element.title];
  final fuse = Fuzzy(options);
  final results = fuse.search(value).map((result) => result.item).toList();
  return data.where((element) => results.contains(element.title)).toList();
}

List<Data> searchHomeExercise(value, List<Data> data) {
  final options = [for (var element in data) element.title!];
  final fuse = Fuzzy(options);
  final results = fuse.search(value).map((result) => result.item).toList();
  return data.where((element) => results.contains(element.title)).toList();
}

List<TrainerModel> searchTariner(value, List<TrainerModel> data) {
  final options = [for (var element in data) element.name];
  final fuse = Fuzzy(options);
  final results = fuse.search(value).map((result) => result.item).toList();
  return data.where((element) => results.contains(element.name)).toList();
}
