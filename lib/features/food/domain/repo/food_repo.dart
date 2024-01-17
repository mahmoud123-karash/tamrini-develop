import 'package:dartz/dartz.dart';
import 'package:tamrini/features/food/data/models/supplement_model/supplement_model.dart';

abstract class FoodRepo {
  Future<Either<String, List<SupplementModel>>> get();
}
