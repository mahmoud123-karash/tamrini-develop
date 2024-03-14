import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/features/store/data/models/category_model/category_model.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';

abstract class StoreRemoteDataSource {
  Future<List<CategoryModel>> get();
  Future<List<StoreModel>> getStores();
}

class StoreRemoteDataSourceImpl extends StoreRemoteDataSource {
  @override
  Future<List<CategoryModel>> get() async {
    List<CategoryModel> list = [];
    var result = await FirebaseFirestore.instance
        .collection('supplements')
        .doc('data')
        .collection('data')
        .get();
    for (var element in result.docs) {
      CategoryModel model = CategoryModel.formJson(element.data(), element.id);
      list.add(model);
    }
    return list;
  }

  @override
  Future<List<StoreModel>> getStores() async {
    List<StoreModel> list = [];
    var result = await FirebaseFirestore.instance.collection('stores').get();
    for (var element in result.docs) {
      StoreModel model = StoreModel.fromMap(element.data());
      list.add(model);
    }
    return list;
  }
}
