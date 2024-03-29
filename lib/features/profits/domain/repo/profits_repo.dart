import 'package:dartz/dartz.dart';
import 'package:tamrini/features/profits/data/models/profits_model/profits_model.dart';

abstract class ProfitsRepo {
  Future<Either<String, List<ProfitsModel>>> get();
  Future<Either<String, List<ProfitsModel>>> accept({
    required ProfitsModel model,
  });
  Future<Either<String, List<ProfitsModel>>> removeRequest({
    required String id,
  });

  Future<Either<String, List<ProfitsModel>>> request({
    required num amount,
    required String cashNumber,
    required String id,
  });

  Future<Either<String, List<ProfitsModel>>> getMyRequests({
    required String uid,
  });
}
