import 'package:fuzzy/data/result.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/exercise_data.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/nutrition/data/models/nutrition_model/nutrition_model.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'package:tamrini/features/diet_food/data/models/diet_food_model.dart/diet_food_model.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';

import '../../features/food/data/models/supplement_model/supplement_data.dart';
import '../../features/questions/data/models/question_model/question_model.dart';

Iterable<Result<dynamic>> getResult(List options, value) {
  final fuzzyOptions = FuzzyOptions(
    shouldNormalize: true,
    sortFn: (a, b) => b.score.compareTo(b.score),
    minMatchCharLength: 5,
  );
  final fuse = Fuzzy(options, options: fuzzyOptions);
  final results = fuse.search(value);
  final filteredResults = results.where((result) => result.score < .20);
  return filteredResults;
}

List<DataModel> searchExercise(value, List<DataModel> data) {
  final options = [for (var element in data) element.title!];
  final filteredResults = getResult(options, value);
  final filteredTitles = filteredResults.map((result) => result.item).toList();
  return data
      .where((element) => filteredTitles.contains(element.title))
      .toList();
}

List<ArticleModel> searchArticles(value, List<ArticleModel> data) {
  final options = [for (var element in data) element.title ?? ''];
  final filteredResults = getResult(options, value);
  final filteredTitles = filteredResults.map((result) => result.item).toList();
  return data
      .where((element) => filteredTitles.contains(element.title))
      .toList();
}

List<GymModel> searchGym(value, List<GymModel> data) {
  final options = [for (var element in data) element.name];
  final filteredResults = getResult(options, value);
  final filteredTitles = filteredResults.map((result) => result.item).toList();
  return data
      .where((element) => filteredTitles.contains(element.name))
      .toList();
}

List<ProductModel> searchProduct(value, List<ProductModel> data) {
  final options = [for (var element in data) element.title];
  final filteredResults = getResult(options, value);
  final filteredTitles = filteredResults.map((result) => result.item).toList();
  return data
      .where((element) => filteredTitles.contains(element.title))
      .toList();
}

List<Data> searchHomeExercise(value, List<Data> data) {
  final options = [for (var element in data) element.title];
  final filteredResults = getResult(options, value);
  final filteredTitles = filteredResults.map((result) => result.item).toList();
  return data
      .where((element) => filteredTitles.contains(element.title))
      .toList();
}

List<TrainerModel> searchTariner(value, List<TrainerModel> data) {
  final options = [for (var element in data) element.user!.name];
  final filteredResults = getResult(options, value);
  final filteredTitles = filteredResults.map((result) => result.item).toList();
  return data
      .where((element) => filteredTitles.contains(element.user!.name))
      .toList();
}

List<DietFoodModel> searchDietFood(value, List<DietFoodModel> data) {
  final options = [for (var element in data) element.title];
  final filteredResults = getResult(options, value);
  final filteredTitles = filteredResults.map((result) => result.item).toList();
  return data
      .where((element) => filteredTitles.contains(element.title))
      .toList();
}

List<QuestionModel> searchQuestion(value, List<QuestionModel> data) {
  final options = [for (var element in data) element.body];
  final filteredResults = getResult(options, value);
  final filteredTitles = filteredResults.map((result) => result.item).toList();
  return data
      .where((element) => filteredTitles.contains(element.body))
      .toList();
}

List<SupplementData> searchSupplement(value, List<SupplementData> data) {
  final options = [for (var element in data) element.title];
  final filteredResults = getResult(options, value);
  final filteredTitles = filteredResults.map((result) => result.item).toList();
  return data
      .where((element) => filteredTitles.contains(element.title))
      .toList();
}

List<NutritionModel> searchNutrition(value, List<NutritionModel> data) {
  final options = [for (var element in data) element.title];
  final filteredResults = getResult(options, value);
  final filteredTitles = filteredResults.map((result) => result.item).toList();
  return data
      .where((element) => filteredTitles.contains(element.title))
      .toList();
}

List<UserModel> searchUser(value, List<UserModel> data) {
  final options = [for (var element in data) element.name];
  final filteredResults = getResult(options, value);
  final filteredTitles = filteredResults.map((result) => result.item).toList();
  return data
      .where((element) => filteredTitles.contains(element.name))
      .toList();
}

List<TraineeModel> searchSubscriber(value, List<TraineeModel> data) {
  final options = [for (var element in data) element.user!.name];
  final filteredResults = getResult(options, value);
  final filteredTitles = filteredResults.map((result) => result.item).toList();
  return data
      .where((element) => filteredTitles.contains(element.user!.name))
      .toList();
}
