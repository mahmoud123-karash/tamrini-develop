import 'package:hive/hive.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/subscribtions/data/models/subscription_model/subscription_model.dart';

abstract class SubscribtionLocalDataSource {
  List<SubscriptionModel> get();
}

class SubscribtionLocalDataSourceImpl extends SubscribtionLocalDataSource {
  @override
  List<SubscriptionModel> get() {
    var box = Hive.box<SubscriptionModel>(subBox);
    List<SubscriptionModel> list = box.values.toList();
    return list;
  }
}
