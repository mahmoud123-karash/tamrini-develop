import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_states.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../../trainee/presentation/manager/trainee_cubit/trainee_cubit.dart';
import 'sub_content_widget.dart';

class TrainerPaymentSuccessContentWidget extends StatelessWidget {
  const TrainerPaymentSuccessContentWidget({
    super.key,
    required this.trainerId,
    required this.traineesCount,
    required this.profits,
    required this.price,
    required this.isSUb,
  });
  final String trainerId;
  final int traineesCount;
  final num profits, price;
  final bool isSUb;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SubContentWidget(
              contentHint: S.of(context).trainer_success_payment,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: BlocConsumer<TraineeCubit, TraineeStates>(
                listener: (context, state) {
                  if (state is ErrorGetTraineesState) {
                    showSnackBar(context, state.message);
                    TraineeCubit.get(context).getData(trainerId: trainerId);
                  }
                  if (state is SucessGetTraineesState) {
                    Navigator.pop(context);
                    showSnackBar(context, S.of(context).success_sub);
                  }
                },
                builder: (context, state) {
                  if (state is LoadingGetTraineesState) {
                    return const CircularProgressIndicator();
                  } else {
                    return customButton(
                      onPressed: () {
                        if (!isSUb) {
                          TraineeCubit.get(context).reNewSubUser(
                            trainerId: trainerId,
                            traineesCount: traineesCount,
                            profits: profits,
                          );
                        } else {
                          TraineeCubit.get(context).subUser(
                            trainerId: trainerId,
                            traineesCount: traineesCount,
                            profits: profits,
                          );
                        }
                      },
                      lable: S.of(context).end_progress,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
