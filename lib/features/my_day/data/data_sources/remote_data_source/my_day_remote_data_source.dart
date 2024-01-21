import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/features/my_day/data/models/day_model/day_model.dart';

abstract class MyDayRemoteDataSource {
  Future<List<DayModel>> get();
}

class MyDayRemoteDataSourceImpl extends MyDayRemoteDataSource {
  @override
  Future<List<DayModel>> get() async {
    List<DayModel> list = [];
    String uid = CacheHelper.getData(key: 'uid');
    var result = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('my_day')
        .doc('data')
        .collection('days')
        .get();

    for (var element in result.docs) {
      DayModel model = DayModel.fromJson(element.data(), element.id);
      list.add(model);
    }
    return list;
  }
}
