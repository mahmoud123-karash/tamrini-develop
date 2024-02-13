import 'package:dartz/dartz.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/course_model.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';

abstract class TraineeRepo {
  Future<Either<String, List<TraineeModel>>> getTrainees({
    required String trainerId,
  });

  Future<Either<String, List<TraineeModel>>> subUser({
    required String trainerId,
    required int traineesCount,
    required num profits,
  });

  Future<Either<String, List<TraineeModel>>> reNewSubUser({
    required String trainerId,
    required TraineeModel model,
  });

  Future<Either<String, List<TraineeModel>>> addNewCourse({
    required TraineeModel model,
    required DayWeekExercises dayWeekExercises,
    required String duration,
    required String notes,
    required String title,
  });

  Future<Either<String, List<TraineeModel>>> addSupplements({
    required TraineeModel model,
    required List<String> supplements,
  });
}
