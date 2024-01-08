import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_message_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_trainer_loading_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/trainer_home_widget.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_cubit.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_states.dart';

class TrainerHomeWidgetBuilder extends StatelessWidget {
  const TrainerHomeWidgetBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainersCubit, TrainersStates>(
      builder: (context, state) {
        if (state is SucessGetTrainersState) {
          if (state.list.isEmpty) {
            return Container();
          } else {
            return TrainerHomeWidget(list: state.list);
          }
        } else if (state is ErrorGetTrainersState) {
          return HomeMessageWidget(message: state.message);
        } else {
          return const LoadingTrainerHomeWidget();
        }
      },
    );
  }
}
