import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/rating/domain/repo/rating_repo.dart';
import 'package:tamrini/features/rating/presentation/manager/store_cubit/rating_states.dart';

class RatingCubit extends Cubit<RatingStates> {
  RatingCubit(this.ratingRepo) : super(InitialRatingState());

  static RatingCubit get(context) => BlocProvider.of(context);
  final RatingRepo ratingRepo;

  double rating = 1;
  void rateProduct({
    required String storeId,
    required String productId,
  }) async {
    emit(LoadingRateProductState());
    var result = await ratingRepo.rateProduct(
      storeId: storeId,
      productId: productId,
      rating: rating,
    );
    result.fold((message) {
      log(message);
      emit(ErrorRateProductState(message));
    }, (r) {
      emit(SucessRateProductState());
    });
  }
}
