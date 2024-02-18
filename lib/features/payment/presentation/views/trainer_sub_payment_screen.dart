import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/services/get_it.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/payment/domain/use_cases/create_transaction_id_use_case.dart';
import 'package:tamrini/features/payment/presentation/manager/payment_cubit/payment_cubit.dart';
import 'package:tamrini/features/payment/presentation/manager/payment_cubit/payment_states.dart';
import 'package:tamrini/features/payment/presentation/views/widgets/payment_custom_button_widget.dart';
import 'package:tamrini/generated/l10n.dart';
import 'package:zaincash/zaincash.dart';

import 'widgets/payment_content_widget.dart';

class TrainerSubPaymentScreen extends StatelessWidget {
  const TrainerSubPaymentScreen({
    Key? key,
    required this.trainerId,
    required this.traineesCount,
    required this.profits,
    required this.price,
  }) : super(key: key);
  final String trainerId;
  final int traineesCount;
  final num profits, price;

  @override
  Widget build(BuildContext context) {
    ZaincashService.paymentStateListener.listen((state) {
      if (state['success'] == 1) {}
      if (state['success'] == 0) {}
    });

    num amount = price;
    return BlocProvider(
      create: (context) => PaymentCubit(
        getIt.get<CreateTranscationIdUseCase>(),
      )..createTransactionId(
          amount: amount,
          orderId: trainerId,
        ),
      child: Scaffold(
        appBar: myAppBar(S.of(context).payment),
        body: BlocBuilder<PaymentCubit, PaymentStates>(
          builder: (context, state) {
            if (state is SucessCreateTransactionIdState) {
              return PaymentContentWidget(
                transactionId: state.token,
                amount: amount,
                id: trainerId,
              );
            } else if (state is ErrorCreateTransactionIdState) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    PaymentCustomButtonWidget(
                      amount: amount,
                      id: trainerId,
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
