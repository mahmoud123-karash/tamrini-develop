import 'package:dartz/dartz.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/features/trainee/data/data_sources/remote_data_source/trainee_remote_data_source.dart';
import 'package:tamrini/features/trainee/data/models/sub_model/trainee_model.dart';
import 'package:tamrini/features/trainee/domain/repo/trainee_repo.dart';

class TraineeRepoImpl extends TraineeRepo {
  final TraineeRemoteDataSource traineeRemoteDataSource;

  TraineeRepoImpl(this.traineeRemoteDataSource);
  @override
  Future<Either<String, List<TraineeModel>>> getTrainees() async {
    try {
      String uid = CacheHelper.getData(key: 'uid');
      List<TraineeModel> list =
          await traineeRemoteDataSource.get(trainerId: uid);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }
}
