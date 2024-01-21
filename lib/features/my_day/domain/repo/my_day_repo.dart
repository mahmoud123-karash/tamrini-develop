import 'package:dartz/dartz.dart';
import 'package:tamrini/features/my_day/data/models/day_model/day_model.dart';

abstract class MyDayRepo {
  Future<Either<String, List<DayModel>>> getData();
  Future<Either<String, List<DayModel>>> addToday();
}
