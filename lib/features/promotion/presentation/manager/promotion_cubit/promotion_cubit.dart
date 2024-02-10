import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/promotion/data/models/promotion_model/promotion_model.dart';
import 'package:tamrini/features/promotion/domain/repo/promotion_repo.dart';
import 'package:tamrini/generated/l10n.dart';

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

  void acceptRefuseRequestpromotion({
    required PromotionModel model,
    required bool isAccept,
    required BuildContext context,
  }) async {
    var result = await promotionRepo.acceptRefuseRequestpromotion(
        model: model, isAccept: isAccept);
    result.fold((message) {
      emit(ErrorGetPromotionsState(message));
    }, (list) {
      showSnackBar(
        context,
        isAccept
            ? S.of(context).accept_request_promotion
            : S.of(context).refuse_request_promotion,
      );
      emit(SuccessGetPromotionsState(list));
    });
  }
}
