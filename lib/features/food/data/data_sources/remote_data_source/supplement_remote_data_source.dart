import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/features/food/data/models/supplement_model/supplement_model.dart';

abstract class SupplementRemoteDataSource {
  Future<List<SupplementModel>> get();
}

class SupplementRemoteDataSourceImpl extends SupplementRemoteDataSource {
  @override
  Future<List<SupplementModel>> get() async {
    List<SupplementModel> list = [];
    var result = await FirebaseFirestore.instance
        .collection('supplements')
        .doc('data')
        .collection('data')
        .get();

    for (var element in result.docs) {
      SupplementModel model =
          SupplementModel.fromJson(element.data(), element.id);

      list.add(model);
    }
    return list;
  }
}
