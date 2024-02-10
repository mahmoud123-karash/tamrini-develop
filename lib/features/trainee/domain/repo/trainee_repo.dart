import 'package:dartz/dartz.dart';
import 'package:tamrini/features/trainee/data/models/sub_model/trainee_model.dart';

abstract class TraineeRepo {
  Future<Either<String, List<TraineeModel>>> getTrainees();
}
