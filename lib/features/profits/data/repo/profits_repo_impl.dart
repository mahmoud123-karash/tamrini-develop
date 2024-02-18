import 'package:dartz/dartz.dart';
import 'package:tamrini/features/profits/data/data_sources/remote_data_source/profits_remote_data_source.dart';
import 'package:tamrini/features/profits/data/models/profits_model/profits_model.dart';
import 'package:tamrini/features/profits/domain/repo/profits_repo.dart';

class ProfitsRepoImpl extends ProfitsRepo {
  final ProfitsRemoteDataSource profitsRemoteDataSource;

  ProfitsRepoImpl(this.profitsRemoteDataSource);
  @override
  Future<Either<String, List<ProfitsModel>>> get() async {
    try {
      List<ProfitsModel> list = await profitsRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ProfitsModel>>> accept({
    required num profits,
  }) {
    // TODO: implement accept
    throw UnimplementedError();
  }

  @override
  Future<Either<String, List<ProfitsModel>>> request({
    required num profits,
  }) {
    // TODO: implement request
    throw UnimplementedError();
  }
}
