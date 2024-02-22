import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/features/nutrition/data/data_source/remote_data_source/nutrition_remote_data_source.dart';
import 'package:tamrini/features/nutrition/data/models/nutrition_model/classification_model.dart';
import 'package:tamrini/features/nutrition/data/models/nutrition_model/nutrition_model.dart';
import 'package:tamrini/features/nutrition/domain/repo/nutrition_repo.dart';
import 'package:uuid/uuid.dart';

class NutritionRepoImpl extends NuritionRepo {
  final NutritionRemoteDataSource nutritionRemoteDataSource;

  NutritionRepoImpl(this.nutritionRemoteDataSource);

  @override
  Future<Either<String, List<ClassificationModel>>> getClassifications() async {
    try {
      List<ClassificationModel> list =
          await nutritionRemoteDataSource.getClassifications();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ClassificationModel>>> addClassifications({
    required String name,
  }) async {
    try {
      var uuid = const Uuid().v4();
      ClassificationModel model =
          ClassificationModel(classification: name, id: uuid);
      await FirebaseFirestore.instance.collection('nutritious').doc(uuid).set(
            model.toJson(),
          );
      List<ClassificationModel> list =
          await nutritionRemoteDataSource.getClassifications();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ClassificationModel>>> editClassifications({
    required String name,
    required String id,
  }) async {
    try {
      ClassificationModel model =
          ClassificationModel(classification: name, id: id);
      await FirebaseFirestore.instance.collection('nutritious').doc(id).update(
            model.toJson(),
          );
      List<ClassificationModel> list =
          await nutritionRemoteDataSource.getClassifications();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<NutritionModel>>> getNutritions({
    required String id,
  }) async {
    try {
      List<NutritionModel> list =
          await nutritionRemoteDataSource.getNutritions(id: id);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<NutritionModel>>> addNutrition({
    required List<NutritionModel> list,
    required String categoryId,
    required String name,
    required double protien,
    required double fat,
    required double carb,
    required double calories,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid');
      NutritionModel model = NutritionModel(
        title: name,
        calories: calories,
        proteins: protien,
        fats: fat,
        carbs: carb,
        writerUid: uid,
        user: uid != adminUid ? getUserFromProfile() : null,
      );
      await FirebaseFirestore.instance
          .collection('nutritious')
          .doc(categoryId)
          .collection('data')
          .add(
            model.toJson(),
          );
      list.add(model);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<NutritionModel>>> editNutrition({
    required List<NutritionModel> list,
    required String categoryId,
    required String name,
    required double protien,
    required double fat,
    required double carb,
    required double calories,
    required NutritionModel oldModel,
  }) async {
    try {
      NutritionModel model = NutritionModel(
        title: name,
        calories: calories,
        proteins: protien,
        fats: fat,
        carbs: carb,
        writerUid: oldModel.writerUid,
        user: oldModel.user,
      );
      await FirebaseFirestore.instance
          .collection('nutritious')
          .doc(categoryId)
          .collection('data')
          .doc(oldModel.id)
          .update(
            model.toJson(),
          );
      list.remove(oldModel);
      list.add(model);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<NutritionModel>>> removeNutrition({
    required List<NutritionModel> list,
    required String id,
    required String categoryId,
  }) async {
    try {
      NutritionModel model = list.firstWhere((element) => element.id == id);
      await FirebaseFirestore.instance
          .collection('nutritious')
          .doc(categoryId)
          .collection('data')
          .doc(id)
          .delete();
      list.remove(model);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }
}
