import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/payment/presentation/views/trainer_sub_payment_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class ReNewCustomButtonWidget extends StatelessWidget {
  const ReNewCustomButtonWidget({
    super.key,
    required this.trainerId,
    required this.traineesCount,
    required this.profits,
    required this.price,
  });
  final String trainerId;
  final int traineesCount;
  final num profits, price;

  @override
  Widget build(BuildContext context) {
    return customButton(
      onPressed: () {
        TrainerSubPaymentScreen(
          trainerId: trainerId,
          traineesCount: traineesCount,
          profits: profits,
          price: price,
        );
        // TraineeCubit.get(context).reNewSubUser(
        //   trainerId: trainerId,
        //   traineesCount: traineesCount,
        //   profits: profits,
        // );
      },
      lable: S.of(context).renew_sub,
    );
  }
}
