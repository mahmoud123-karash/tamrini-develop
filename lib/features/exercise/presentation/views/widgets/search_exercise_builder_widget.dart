import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/exercise/presentation/views/category_exercices_screen.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/exercise_type_widget.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/loading_type_widget.dart';
import 'package:tamrini/features/home/presentation/manager/exercise_cubit/exercise_cubit.dart';
import 'package:tamrini/features/home/presentation/manager/exercise_cubit/exercise_states.dart';
import 'package:tamrini/generated/l10n.dart';

class SearchExerciseBuilderWidget extends StatelessWidget {
  const SearchExerciseBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseCubit, ExerciseStates>(
      builder: (context, state) {
        if (state is SucessGetExerciseState) {
          if (state.exercises.isEmpty) {
            return Container();
          }
          return ExerciseTypeWidget(
            image: Assets.imagesGymloca2,
            lable: S.of(context).search_yourself,
            onPressed: () {
              navigateTo(context, const CategoryExercisesScreen());
            },
          );
        } else {
          return const LoadingTypeWidget();
        }
      },
    );
  }
}
