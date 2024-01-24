import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/exercise/presentation/views/add_new_section_screen.dart';
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
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              addCustomButton(
                onPressed: () {
                  navigateTo(context, const AddNewSectionScreen());
                },
                lable: S.of(context).add_new_section,
              ),
              const SizedBox(
                height: 20,
              ),
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
                height: 20,
              ),
              CategoryGridViewWidget(models: models),
            ],
          ),
        ),
      ),
    );
  }
}
