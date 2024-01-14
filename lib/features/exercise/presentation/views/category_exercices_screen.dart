import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/home/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/home/data/models/exercise_model/exercise_model.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/all_exercises_container_widget.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/category_grid_view_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'all_exercises_category_screen.dart';

class CategoryExercisesScreen extends StatelessWidget {
  const CategoryExercisesScreen({Key? key, required this.models})
      : super(key: key);
  final List<ExerciseModel> models;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).categoryEx,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AllExercisesContainerWidget(
                onPressed: () {
                  List<DataModel> exercises = [];
                  for (var element in models) {
                    exercises.addAll(element.data!);
                  }
                  if (exercises.isNotEmpty) {
                    navigateTo(
                      context,
                      AllExercisesCategoryScreen(
                        list: exercises,
                        title: S.of(context).allEx,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              CategoryGridViewWidget(models: models),
            ],
          ),
        ),
      ),
    );
  }
}
