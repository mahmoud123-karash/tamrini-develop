import 'package:dartz/dartz.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/gym/data/models/subscriber_model/subscriber_model.dart';

abstract class GymRepo {
  Future<Either<String, List<GymModel>>> getGyms({
    required bool update,
  });

  Future<Either<String, List<GymModel>>> addGym({
    required List<String> paths,
    required String name,
    required String description,
    required int price,
    required double lat,
    required double long,
  });
  Future<Either<String, List<GymModel>>> editGym({
    required List<String> paths,
    required String name,
    required String description,
    required int price,
    required double lat,
    required double long,
    required GymModel oldModel,
    required List<String> images,
  });

  Future<Either<String, List<GymModel>>> banGym({
    required String gymId,
    required String ownerId,
    required bool isBannd,
  });

  Future<Either<String, List<SubscriberModel>>> getSubscribers({
    required String gymId,
  });

  Future<Either<String, List<SubscriberModel>>> subUser({
    required String gymId,
    required int count,
    required num price,
  });

  Future<Either<String, List<SubscriberModel>>> renewSub({
    required String gymId,
    required num price,
    required String subId,
  });
}
