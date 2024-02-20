import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/services/get_it.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/payment/domain/use_cases/create_transaction_id_use_case.dart';
import 'package:tamrini/features/payment/presentation/manager/payment_cubit/payment_cubit.dart';
import 'package:tamrini/features/payment/presentation/manager/payment_cubit/payment_states.dart';
import 'package:tamrini/features/payment/presentation/manager/status_cubit/status_cubit.dart';
import 'package:tamrini/generated/l10n.dart';
import 'widgets/payment_content_widget.dart';
import 'widgets/payment_error_builder_widget.dart';

class GymSubPaymentScreen extends StatelessWidget {
  const GymSubPaymentScreen({
    Key? key,
    required this.gymId,
    required this.subId,
    required this.count,
    required this.price,
    required this.profits,
  }) : super(key: key);
  final String gymId, subId;
  final int count;
  final num price, profits;

  @override
  Widget build(BuildContext context) {
    num amount = price;
    return BlocProvider(
      create: (context) => PaymentCubit(
        getIt.get<CreateTranscationIdUseCase>(),
      )..createTransactionId(
          amount: amount,
          orderId: gymId,
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
                  return PaymentContentWidget(
                    transactionId: state.id!,
                    amount: amount,
                    id: gymId,
                    onSuccess: () {},
                  );
                } else {
                  return PaymentErrorBuilderWidget(
                    message: S.of(context).error_payment,
                    id: gymId,
                    amount: amount,
                  );
                }
              } else if (state is ErrorCreateTransactionIdState) {
                return PaymentErrorBuilderWidget(
                  message: state.message,
                  id: gymId,
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
