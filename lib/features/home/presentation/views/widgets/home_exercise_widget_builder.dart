import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/home/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/home/presentation/manager/exercise_cubit/exercise_cubit.dart';
import 'package:tamrini/features/home/presentation/manager/exercise_cubit/exercise_states.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_exercise_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_loading_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_message_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class HomeExerciseWidgetBuilder extends StatelessWidget {
  const HomeExerciseWidgetBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseCubit, ExerciseStates>(
      builder: (context, state) {
        if (state is SucessGetExerciseState) {
          if (state.exercises.isEmpty) {
            return Container();
          } else {
            List<DataModel> list = genrateHomeList(state);
            return HomeExerciseWidget(
              exercises: list,
              allExercises: state.exercises,
            );
          }
        } else if (state is ErrorGetExerciseState) {
          return HomeMessageWidget(message: state.message);
        } else {
          return HomeLoadingWidget(
            lable: S.of(context).exercise,
          );
        }
      },
    );
  }

  List<DataModel> genrateHomeList(SucessGetExerciseState state) {
    Random random = Random();
    List<DataModel> list = [];
    for (var element in state.exercises) {
      DataModel model = element.data![random.nextInt(element.data!.length)];
      if (list.length < 5) {
        list.add(model);
      }
    }
    return list;
  }
}
