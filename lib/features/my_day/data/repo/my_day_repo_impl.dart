import 'package:dartz/dartz.dart';
import 'package:tamrini/features/my_day/data/data_sources/local_data_source/my_day_local_data_source.dart';
import 'package:tamrini/features/my_day/data/data_sources/remote_data_source/my_day_remote_data_source.dart';
import 'package:tamrini/features/my_day/data/models/day_model/day_model.dart';
import 'package:tamrini/features/my_day/domain/repo/my_day_repo.dart';

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
}
