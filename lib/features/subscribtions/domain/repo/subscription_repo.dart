import 'package:dartz/dartz.dart';
import 'package:tamrini/features/subscribtions/data/models/subscription_model/subscription_model.dart';

abstract class SubscriptionRepo {
  Future<Either<String, List<SubscriptionModel>>> get();
}
