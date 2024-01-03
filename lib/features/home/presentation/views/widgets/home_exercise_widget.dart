import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/home/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/home/data/models/exercise_model/exercise_model.dart';
import 'package:tamrini/features/home/presentation/views/widgets/title_and_more_button_row_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../category_exercices_screen.dart';
import 'home_exercises_list_view_widget.dart';

class HomeExerciseWidget extends StatelessWidget {
  const HomeExerciseWidget(
      {super.key, required this.exercises, required this.allExercises});
  final List<DataModel> exercises;
  final List<ExerciseModel> allExercises;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TitleAndMoreButtonRowWidget(
          lable: S.of(context).exercise,
          onPressed: () {
            navigateTo(context, CategoryExercisesScreen(models: allExercises));
          },
        ),
        const SizedBox(
          height: 10,
        ),
        ExercisesListViewWidget(
          exercises: exercises,
        ),
        const Divider(
          height: 50,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }
}
