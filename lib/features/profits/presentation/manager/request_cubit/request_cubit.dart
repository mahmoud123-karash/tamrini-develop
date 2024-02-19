import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/profits/domain/repo/profits_repo.dart';

import 'request_states.dart';

class RequestCubit extends Cubit<RequestStates> {
  RequestCubit(this.profitsRepo) : super(InitialRequestState());
  static RequestCubit get(context) => BlocProvider.of(context);

  final ProfitsRepo profitsRepo;

  bool isRequest = false;
  void request({
    required num amount,
    required String id,
  }) async {
    emit(LoadingRequestState());
    var result = await profitsRepo.request(amount: amount, id: id);
    result.fold((message) {
      emit(ErrorRequestState(message));
    }, (list) {
      emit(SuccessRequestState());
    });
  }
}
