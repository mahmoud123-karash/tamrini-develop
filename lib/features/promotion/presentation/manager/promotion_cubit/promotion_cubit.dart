import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/promotion/domain/repo/promotion_repo.dart';

import 'promotion_states.dart';

class PromotionCubit extends Cubit<PromotionStates> {
  PromotionCubit(this.promotionRepo) : super(InitailPromotionState());
  static PromotionCubit get(context) => BlocProvider.of(context);

  final PromotionRepo promotionRepo;

  void getData() async {
    emit(LoadingGetPromotionsState());
    var result = await promotionRepo.getPromotion();
    result.fold((message) {
      emit(ErrorGetPromotionsState(message));
    }, (list) {
      emit(SuccessGetPromotionsState(list));
    });
  }

  void requestpromotion({required String promotionType}) async {
    emit(LoadingGetPromotionsState());
    var result =
        await promotionRepo.requestpromotion(promotionType: promotionType);
    result.fold((message) {
      emit(ErrorGetPromotionsState(message));
    }, (list) {
      emit(SuccessGetPromotionsState(list));
    });
  }
}
