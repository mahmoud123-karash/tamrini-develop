import 'package:hive/hive.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/profile/data/models/profile_model/profile_model.dart';

abstract class ProfileLocalDataSource {
  List<ProfileModel> get();
}

class ProfileLocalDataSourceImpl extends ProfileLocalDataSource {
  @override
  List<ProfileModel> get() {
    var box = Hive.box<ProfileModel>(profileBox);
    return box.values.toList();
  }
}
