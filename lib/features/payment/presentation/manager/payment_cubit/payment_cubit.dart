import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/payment/domain/use_cases/create_transaction_id_use_case.dart';
import 'package:tamrini/features/payment/presentation/manager/payment_cubit/payment_states.dart';

class PaymentCubit extends Cubit<PaymentStates> {
  PaymentCubit(this.createTranscationIdUseCase) : super(InitialPaymentState());

  static PaymentCubit get(context) => BlocProvider.of(context);

  final CreateTranscationIdUseCase createTranscationIdUseCase;

  void createTransactionId({
    required num amount,
    required String orderId,
  }) async {
    emit(LoadingCreateTransactionIdState());
    var result = await createTranscationIdUseCase.create(
      amount: amount,
      orderId: orderId,
    );
    result.fold(
      (message) {
        emit(ErrorCreateTransactionIdState(message));
      },
      (id) {
        emit(SucessCreateTransactionIdState(id));
      },
    );
  }
}
