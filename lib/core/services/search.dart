import 'package:fuzzy/fuzzy.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/exercise_data.dart';
import 'package:tamrini/features/food/data/models/nutrition_model/nutrition_model.dart';
import 'package:tamrini/features/home/data/models/article_model/article_model.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/home/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/home/data/models/store_model/product_model.dart';
import 'package:tamrini/features/diet_food/data/models/diet_food_model.dart/diet_food_model.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';

import '../../features/food/data/models/supplement_model/supplement_data.dart';
import '../../features/questions/data/models/question_model/question_model.dart';

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

List<DietFoodModel> searchDietFood(value, List<DietFoodModel> data) {
  final options = [for (var element in data) element.title];
  final fuse = Fuzzy(options);
  final results = fuse.search(value).map((result) => result.item).toList();
  return data.where((element) => results.contains(element.title)).toList();
}

List<QuestionModel> searchQuestion(value, List<QuestionModel> data) {
  final options = [for (var element in data) element.body];
  final fuse = Fuzzy(options);
  final results = fuse.search(value).map((result) => result.item).toList();
  return data.where((element) => results.contains(element.body)).toList();
}

List<SupplementData> searchSupplement(value, List<SupplementData> data) {
  final options = [for (var element in data) element.title];
  final fuse = Fuzzy(options);
  final results = fuse.search(value).map((result) => result.item).toList();
  return data.where((element) => results.contains(element.title)).toList();
}

List<NutritionModel> searchNutrition(value, List<NutritionModel> data) {
  final options = [for (var element in data) element.title];
  final fuse = Fuzzy(options);
  final results = fuse.search(value).map((result) => result.item).toList();
  return data.where((element) => results.contains(element.title)).toList();
}
