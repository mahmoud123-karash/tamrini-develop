import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/exercise/presentation/views/category_exercices_screen.dart';

import '../../../data/models/exercise_model/data_model.dart';

class MoveExerciseIconWidget extends StatelessWidget {
  const MoveExerciseIconWidget({
    super.key,
    required this.model,
  });
  final DataModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        onPressed: () {
          navigateTo(context, CategoryExercisesScreen(oldModel: model));
        },
        icon: const Icon(Icons.move_down_rounded),
        color: Colors.red,
      ),
    );
  }
}
