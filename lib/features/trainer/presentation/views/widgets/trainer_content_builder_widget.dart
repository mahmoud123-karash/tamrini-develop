import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_cubit.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_states.dart';
import 'package:tamrini/features/trainer/presentation/views/widgets/trainer_message_widget.dart';
import 'package:tamrini/features/trainer/presentation/views/widgets/trainers_content_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class TrainerContentBuilderWidget extends StatelessWidget {
  const TrainerContentBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainersCubit, TrainersStates>(
      builder: (context, state) {
        if (state is SucessGetTrainersState) {
          if (state.list.isEmpty) {
            return TrainerMessageWidget(message: S.of(context).no_trainers);
          } else {
            return TrainersContentWidget(list: state.list);
          }
        } else if (state is ErrorGetTrainersState) {
          return TrainerMessageWidget(message: state.message);
        } else {
          return Center(
            child: SizedBox(
              height: 150,
              child: Image.asset(Assets.imagesLoading),
            ),
          );
        }
      },
    );
  }
}
