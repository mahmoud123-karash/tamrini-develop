import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/services/get_it.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/payment/domain/use_cases/create_transaction_id_use_case.dart';
import 'package:tamrini/features/payment/presentation/manager/payment_cubit/payment_cubit.dart';
import 'package:tamrini/features/payment/presentation/manager/payment_cubit/payment_states.dart';
import 'package:tamrini/features/payment/presentation/manager/status_cubit/status_cubit.dart';
import 'package:tamrini/generated/l10n.dart';
import 'widgets/payment_error_builder_widget.dart';
import 'widgets/trainer_payment_success_builder_widget.dart';

class TrainerSubPaymentScreen extends StatelessWidget {
  const TrainerSubPaymentScreen({
    Key? key,
    required this.trainerId,
    required this.traineesCount,
    required this.profits,
    required this.price,
    required this.isSUb,
  }) : super(key: key);
  final String trainerId;
  final int traineesCount;
  final num profits, price;
  final bool isSUb;

  @override
  Widget build(BuildContext context) {
    num amount = price;
    return BlocProvider(
      create: (context) => PaymentCubit(
        getIt.get<CreateTranscationIdUseCase>(),
      )..createTransactionId(
          amount: amount,
          orderId: trainerId,
        ),
      child: BlocProvider(
        create: (context) => StatusCubit(
          getIt.get<CreateTranscationIdUseCase>(),
        ),
        child: Scaffold(
          appBar: myAppBar(S.of(context).payment),
          body: BlocBuilder<PaymentCubit, PaymentStates>(
            builder: (context, state) {
              if (state is SucessCreateTransactionIdState) {
                if (state.id != null) {
                  return TrainerPaymentSucessBuilderWidget(
                    id: state.id!,
                    amount: amount,
                    trainerId: trainerId,
                    traineesCount: traineesCount,
                    profits: profits,
                    price: price,
                    isSUb: isSUb,
                  );
                } else {
                  return PaymentErrorBuilderWidget(
                    message: S.of(context).error_payment,
                    id: trainerId,
                    amount: amount,
                  );
                }
              } else if (state is ErrorCreateTransactionIdState) {
                return PaymentErrorBuilderWidget(
                  message: state.message,
                  id: trainerId,
                  amount: amount,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
