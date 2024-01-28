import 'package:hive/hive.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/store/data/models/category_model/category_model.dart';

abstract class StoreLocalDataSource {
  List<CategoryModel> get();
}

class StoreLocalDataSourceImpl extends StoreLocalDataSource {
  @override
  List<CategoryModel> get() {
    var box = Hive.box<CategoryModel>(storeBox);
    return box.values.toList();
  }
}
