import 'package:tamrini/features/promotion/data/models/promotion_model/promotion_model.dart';

abstract class PromotionStates {}

class InitailPromotionState extends PromotionStates {}

class LoadingGetPromotionsState extends PromotionStates {}

class SuccessGetPromotionsState extends PromotionStates {
  final List<PromotionModel> list;

  SuccessGetPromotionsState(this.list);
}

class ErrorGetPromotionsState extends PromotionStates {
  final String message;

  ErrorGetPromotionsState(this.message);
}
