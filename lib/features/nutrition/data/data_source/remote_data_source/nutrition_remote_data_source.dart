import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/services/location.dart';
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
      UserModel userModel = await getAsker(element);
      NutritionModel model =
          NutritionModel.fromJson(element.data(), element.id, id, userModel);
      list.add(model);
    }
    return list;
  }

  Future<UserModel> getAsker(
    QueryDocumentSnapshot<Map<String, dynamic>> element,
  ) async {
    String askerUid = element.data()['writerUid'] ?? adminUid;
    var result = await FirebaseFirestore.instance
        .collection('users')
        .doc(askerUid)
        .get();
    GeoPoint defultLocation = const GeoPoint(33.312805, 44.361488);
    GeoPoint location = result.data() == null
        ? defultLocation
        : result.data()!['location'] ?? defultLocation;
    String address = await getAddress(location: location);
    UserModel user = UserModel.fromMap(result.data()!, result.id, address);
    return user;
  }
}
