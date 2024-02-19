import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/profits/data/models/profits_model/profits_model.dart';
import 'package:tamrini/features/profits/domain/repo/profits_repo.dart';
import 'package:tamrini/features/profits/presentation/manager/profits_cubit/profits_states.dart';

class ProfitsCubit extends Cubit<ProfitsStates> {
  ProfitsCubit(this.profitsRepo) : super(InitialProfitsState());
  static ProfitsCubit get(context) => BlocProvider.of(context);

  final ProfitsRepo profitsRepo;

  void getData() async {
    emit(LoadingGetProfitsRequestsState());
    var result = await profitsRepo.get();
    result.fold((message) {
      emit(ErrorGetProfitsRequestsState(message));
    }, (list) {
      emit(SuccessGetProfitsRequestsState(list));
    });
  }

  void accept({
    required num amount,
    required ProfitsModel model,
  }) async {
    emit(LoadingGetProfitsRequestsState());
    var result = await profitsRepo.accept(amount: amount, model: model);
    result.fold((message) {
      emit(ErrorGetProfitsRequestsState(message));
    }, (list) {
      emit(SuccessGetProfitsRequestsState(list));
    });
  }
}
