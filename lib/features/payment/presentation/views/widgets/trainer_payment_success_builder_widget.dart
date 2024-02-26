import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/payment/presentation/manager/status_cubit/status_cubit.dart';
import 'package:tamrini/features/payment/presentation/manager/status_cubit/status_states.dart';
import 'package:tamrini/features/payment/presentation/views/widgets/payment_content_widget.dart';

import 'trainer_payment_success_content_widget.dart';

class TrainerPaymentSucessBuilderWidget extends StatelessWidget {
  const TrainerPaymentSucessBuilderWidget({
    super.key,
    required this.id,
    required this.amount,
    required this.trainerId,
    required this.traineesCount,
    required this.profits,
    required this.price,
    required this.isSUb,
  });
  final num amount;
  final String trainerId, id;
  final int traineesCount;
  final num profits, price;
  final bool isSUb;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusCubit, StatusStates>(
      builder: (context, state) {
        if (state is SucessStatusState) {
          return TrainerPaymentSuccessContentWidget(
            trainerId: trainerId,
            traineesCount: traineesCount,
            profits: profits,
            price: price,
            isSUb: isSUb,
          );
        } else {
          return PaymentContentWidget(
            transactionId: id,
            amount: amount,
            onSuccess: () {},
          );
        }
      },
    );
  }
}
