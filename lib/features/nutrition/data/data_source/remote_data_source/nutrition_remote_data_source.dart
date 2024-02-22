import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/features/nutrition/data/models/nutrition_model/classification_model.dart';
import 'package:tamrini/features/nutrition/data/models/nutrition_model/nutrition_model.dart';

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
      String writerUid = element.data()['writerUid'] ?? adminUid;
      UserModel? user;
      if (writerUid != adminUid) {
        user = await getUser(writerUid);
      } else {
        user = null;
      }
      NutritionModel model =
          NutritionModel.fromJson(element.data(), element.id, id, user);
      list.add(model);
    }
    return list;
  }
}
