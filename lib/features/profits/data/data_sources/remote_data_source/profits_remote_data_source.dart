import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/features/profits/data/models/profits_model/profits_model.dart';

abstract class ProfitsRemoteDataSource {
  Future<List<ProfitsModel>> get();
}

class ProfitsRemoteDataSourceImpl extends ProfitsRemoteDataSource {
  @override
  Future<List<ProfitsModel>> get() async {
    List<ProfitsModel> list = [];
    var result = await FirebaseFirestore.instance.collection('profits').get();
    for (var element in result.docs) {
      ProfitsModel model = ProfitsModel.fromJson(element.data());
      list.add(model);
    }
    return list;
  }
}
