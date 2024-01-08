import 'package:dartz/dartz.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';

abstract class TrainerRepo {
  Future<Either<String, List<TrainerModel>>> get();
}
