import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/features/suggest_exercise/data/models/suggest_model/suggest_model.dart';

abstract class SuggestRemoteDataSource {
  Future<List<SuggestModel>> get();
}

class SuggestRemoteDataSourceImpl extends SuggestRemoteDataSource {
  @override
  Future<List<SuggestModel>> get() async {
    List<SuggestModel> list = [];
    var result = await FirebaseFirestore.instance
        .collection('suggested_exercises')
        .get();

    for (var element in result.docs) {
      SuggestModel model = SuggestModel.fromJson(element.data());
      list.add(model);
    }
    return list;
  }
}
