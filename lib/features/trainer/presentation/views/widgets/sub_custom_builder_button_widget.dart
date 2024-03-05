import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_states.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../../payment/presentation/views/trainer_sub_payment_screen.dart';

class SubCustomBuilderButtonWidget extends StatelessWidget {
  const SubCustomBuilderButtonWidget({
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
    String uid = CacheHelper.getData(key: 'uid') ?? "";

    return BlocBuilder<TraineeCubit, TraineeStates>(
      builder: (context, state) {
        if (state is LoadingGetTraineesState) {
          return const Padding(
            padding: EdgeInsets.all(15),
            child: CircularProgressIndicator(),
          );
        } else {
          return customButton(
            onPressed: () {
              if (uid != '') {
                navigateTo(
                  context,
                  TrainerSubPaymentScreen(
                    trainerId: trainerId,
                    traineesCount: traineesCount,
                    profits: profits,
                    price: price,
                    isSUb: true,
                  ),
                );
              } else {
                showWaringLoginDialog(context);
              }
            },
            lable: S.of(context).sub,
          );
        }
      },
    );
  }
}
