import 'package:dartz/dartz.dart';
import 'package:tamrini/features/promotion/data/models/promotion_model/promotion_model.dart';

abstract class PromotionRepo {
  Future<Either<String, List<PromotionModel>>> getPromotion();
  Future<Either<String, List<PromotionModel>>> requestpromotion({
    required String promotionType,
  });

  Future<Either<String, List<PromotionModel>>> acceptRefuseRequestpromotion({
    required PromotionModel model,
    required bool isAccept,
  });
}
