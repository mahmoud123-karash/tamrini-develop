import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/payment/presentation/manager/status_cubit/status_cubit.dart';
import 'package:tamrini/features/payment/presentation/manager/status_cubit/status_states.dart';
import 'package:tamrini/features/payment/presentation/views/widgets/payment_content_widget.dart';

import 'gym_sub_content_widget.dart';

class GymSubPaymentContentBuilderWidget extends StatelessWidget {
  const GymSubPaymentContentBuilderWidget({
    super.key,
    required this.transactionId,
    required this.gymId,
    required this.subId,
    required this.count,
    required this.price,
    required this.profits,
  });
  final String transactionId;
  final String gymId, subId;
  final int count;
  final num price, profits;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusCubit, StatusStates>(
      builder: (context, state) {
        if (state is SucessStatusState) {
          return GymSubContentWidget(
            gymId: gymId,
            subId: subId,
            count: count,
            price: price,
            profits: profits,
          );
        } else {
          return PaymentContentWidget(
            transactionId: transactionId,
            amount: price,
            onSuccess: () {},
          );
        }
      },
    );
  }
}
