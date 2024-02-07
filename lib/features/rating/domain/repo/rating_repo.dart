import 'package:dartz/dartz.dart';

abstract class RatingRepo {
  Future<Either<String, String>> rateProduct({
    required String storeId,
    required String productId,
    required double rating,
  });
}
