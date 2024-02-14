import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class ReNewCustomButtonWidget extends StatelessWidget {
  const ReNewCustomButtonWidget({
    super.key,
    required this.trainerId,
    required this.traineesCount,
    required this.profits,
  });
  final String trainerId;
  final int traineesCount;
  final num profits;

  @override
  Widget build(BuildContext context) {
    return customButton(
      onPressed: () {
        TraineeCubit.get(context).reNewSubUser(
          trainerId: trainerId,
          traineesCount: traineesCount,
          profits: profits,
        );
      },
      lable: S.of(context).renew_sub,
    );
  }
}
