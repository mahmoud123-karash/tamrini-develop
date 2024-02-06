import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:tamrini/core/contants/constants.dart';
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
    var result =
        await FirebaseFirestore.instance.collection('Categories').get();

    for (var element in result.docs) {
      CategoryModel model = CategoryModel.formJson(element.data());
      list.add(model);
    }
    var box = Hive.box<CategoryModel>(storeBox);
    box.addAll(list);
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
