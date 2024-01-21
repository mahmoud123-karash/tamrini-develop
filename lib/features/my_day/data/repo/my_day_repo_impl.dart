import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/my_day/data/data_sources/local_data_source/my_day_local_data_source.dart';
import 'package:tamrini/features/my_day/data/data_sources/remote_data_source/my_day_remote_data_source.dart';
import 'package:tamrini/features/my_day/data/models/day_model/calculator_model.dart';
import 'package:tamrini/features/my_day/data/models/day_model/day_model.dart';
import 'package:tamrini/features/my_day/domain/repo/my_day_repo.dart';
import 'package:uuid/uuid.dart';

class MyDayRepoImpl extends MyDayRepo {
  final MyDayRemoteDataSource myDayRemoteDataSource;
  final MyDayLocalDataSource myDayLocalDataSource;

  MyDayRepoImpl(this.myDayRemoteDataSource, this.myDayLocalDataSource);
  @override
  Future<Either<String, List<DayModel>>> getData() async {
    try {
      List<DayModel> localList = myDayLocalDataSource.get();
      if (localList.isNotEmpty) {
        return right(localList);
      }
      List<DayModel> list = await myDayRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<DayModel>>> addToday() async {
    try {
      String uid = CacheHelper.getData(key: 'uid');
      var uuid = const Uuid().v4();
      DayModel model = DayModel(
        model: CalculatorModel(
          calories: 0,
          protein: 0,
          fat: 0,
          carbs: 0,
        ),
        nutrients: {},
        id: uuid,
        date: Timestamp.now(),
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('myday')
          .doc(uuid)
          .set(model.toJson());
      var box = Hive.box<DayModel>(dayBox);
      box.add(model);
      return right(box.values.toList());
    } catch (e) {
      return left(e.toString());
    }
  }
}
