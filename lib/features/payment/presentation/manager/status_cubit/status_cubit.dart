import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/payment/domain/use_cases/create_transaction_id_use_case.dart';
import 'status_states.dart';

class StatusCubit extends Cubit<StatusStates> {
  StatusCubit(this.createTranscationIdUseCase) : super(InitialStatusState());

  static StatusCubit get(context) => BlocProvider.of(context);

  final CreateTranscationIdUseCase createTranscationIdUseCase;

  void getStatus({
    required String id,
  }) async {
    emit(LoadingGetStatusState());
    var result = await createTranscationIdUseCase.listenOnStream(id: id);
    result.fold(
      (message) {
        emit(ErrorGetStatusState(message));
      },
      (model) {
        if (model.status == 'success') {
          emit(SucessStatusState());
        } else if (model.status == 'failed') {
          emit(FailedStatusState(model.msg));
        } else {
          emit(PendingStatusState());
        }
      },
    );
  }
}
