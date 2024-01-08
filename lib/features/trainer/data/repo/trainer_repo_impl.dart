import 'package:dartz/dartz.dart';
import 'package:tamrini/features/trainer/data/data_sources/remote_data_source/trainer_remote_data_source.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/features/trainer/domain/repo/trainer_repo.dart';

class TrainerRepoImpl extends TrainerRepo {
  final TrainerRemoteDataSource trainerRemoteDataSource;

  TrainerRepoImpl(this.trainerRemoteDataSource);
  @override
  Future<Either<String, List<TrainerModel>>> get() async {
    try {
      List<TrainerModel> list = await trainerRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }
}
