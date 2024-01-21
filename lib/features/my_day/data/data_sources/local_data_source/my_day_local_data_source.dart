import 'package:hive/hive.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/my_day/data/models/day_model/day_model.dart';

abstract class MyDayLocalDataSource {
  List<DayModel> get();
}

class MyDayLocalDataSourceImpl extends MyDayLocalDataSource {
  @override
  List<DayModel> get() {
    var box = Hive.box<DayModel>(dayBox);
    return box.values.toList();
  }
}
