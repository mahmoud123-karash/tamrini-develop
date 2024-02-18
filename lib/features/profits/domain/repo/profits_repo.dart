import 'package:dartz/dartz.dart';
import 'package:tamrini/features/profits/data/models/profits_model/profits_model.dart';

abstract class ProfitsRepo {
  Future<Either<String, List<ProfitsModel>>> get();
  Future<Either<String, List<ProfitsModel>>> request({
    required num profits,
  });
  Future<Either<String, List<ProfitsModel>>> accept({
    required num profits,
  });
}
