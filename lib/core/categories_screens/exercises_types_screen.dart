import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/widgets/category_item_widget.dart';
import 'package:tamrini/features/home_exercise/presentation/views/home_category_exercises_screen.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/gym_type_builder_widget.dart';
import 'package:tamrini/features/trainer/presentation/views/trainers_screen.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../features/exercise/presentation/views/widgets/search_exercise_builder_widget.dart';

class ExercisesTypesScreen extends StatelessWidget {
  const ExercisesTypesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SearchExerciseBuilderWidget(),
          CategoryItemWidget(
            image: Assets.imagesHomeExer1,
            lable: S.of(context).home_exercises,
            onPressed: () {
              navigateTo(context, const HomeCategoryExercisesScreen());
            },
          ),
          const GymTypeBuilderWidget(),
          CategoryItemWidget(
            image: Assets.imagesTrainer,
            lable: S.of(context).trainer,
            onPressed: () {
              navigateTo(
                context,
                const TrainersScreen(),
              );
            },
          ),
        ],
      ),
    );
  }
}
