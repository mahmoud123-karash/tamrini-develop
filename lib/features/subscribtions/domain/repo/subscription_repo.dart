import 'package:dartz/dartz.dart';
import 'package:tamrini/features/subscribtions/data/models/subscription_model/subscription_model.dart';

abstract class SubscriptionRepo {
  Future<Either<String, List<SubscriptionModel>>> get();

  Future<Either<String, List<SubscriptionModel>>> subUser({
    required String gymId,
    required int count,
    required num price,
    required num profits,
  });

  Future<Either<String, List<SubscriptionModel>>> renewSub({
    required String gymId,
    required String subId,
    required num price,
    required num profits,
    required int count,
  });
}
