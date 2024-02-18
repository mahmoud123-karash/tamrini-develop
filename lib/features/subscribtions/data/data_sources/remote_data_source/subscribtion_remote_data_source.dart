import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/subscribtions/data/models/subscription_model/subscription_model.dart';

abstract class SubscriptionRemoteDataSource {
  Future<List<SubscriptionModel>> get();
}

class SubscriptionRemoteDataSourceImpl extends SubscriptionRemoteDataSource {
  @override
  Future<List<SubscriptionModel>> get() async {
    List<SubscriptionModel> list = [];
    String uid = CacheHelper.getData(key: 'uid');
    var result = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('Subscriptions')
        .orderBy('subDate', descending: true)
        .get();
    for (var element in result.docs) {
      SubscriptionModel model = SubscriptionModel.fromJson(element.data());
      list.add(model);
    }
    var box = Hive.box<SubscriptionModel>(subBox);
    await box.addAll(list);
    return list;
  }
}
