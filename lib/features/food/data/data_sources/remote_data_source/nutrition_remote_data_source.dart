import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/features/food/data/models/nutrition_model.dart/classification_model.dart';
import 'package:tamrini/features/food/data/models/nutrition_model.dart/nutrition_model.dart';

abstract class NutritionRemoteDataSource {
  Future<List<ClassificationModel>> getClassifications();
  Future<List<NutritionModel>> getNutritions({required String id});
}

class NutritionRemoteDataSourceImpl extends NutritionRemoteDataSource {
  @override
  Future<List<ClassificationModel>> getClassifications() async {
    List<ClassificationModel> classifications = [];
    var result =
        await FirebaseFirestore.instance.collection('nutritious').get();

    for (var element in result.docs) {
      ClassificationModel model = ClassificationModel.fromJson(element.data());
      classifications.add(model);
    }
    return classifications;
  }

  @override
  Future<List<NutritionModel>> getNutritions({required String id}) async {
    List<NutritionModel> list = [];
    var result = await FirebaseFirestore.instance
        .collection('nutritious')
        .doc(id)
        .collection('data')
        .orderBy('title', descending: false)
        .get();

    for (var element in result.docs) {
      NutritionModel model =
          NutritionModel.fromJson(element.data(), element.id);
      list.add(model);
    }
    return list;
  }
}
