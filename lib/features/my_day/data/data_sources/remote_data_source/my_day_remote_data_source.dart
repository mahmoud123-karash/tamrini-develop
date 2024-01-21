import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/features/my_day/data/models/day_model/day_model.dart';

import '../../../../../core/contants/constants.dart';

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
        .collection('myday')
        .get();

    for (var element in result.docs) {
      DayModel model = DayModel.fromJson(element.data());
      list.add(model);
    }
    var box = Hive.box<DayModel>(dayBox);
    box.addAll(list);
    return list;
  }
}
