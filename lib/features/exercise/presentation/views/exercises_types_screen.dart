import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/home_exercise/presentation/views/home_category_exercises_screen.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/exercise_type_widget.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/gym_type_builder_widget.dart';
import 'package:tamrini/features/trainer/presentation/views/trainers_screen.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/search_exercise_builder_widget.dart';

class ExercisesTypesScreen extends StatefulWidget {
  const ExercisesTypesScreen({Key? key}) : super(key: key);

  @override
  State<ExercisesTypesScreen> createState() => _ExercisesTypesScreenState();
}

class _ExercisesTypesScreenState extends State<ExercisesTypesScreen> {
  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage(Assets.imagesGymloca2), context);
    precacheImage(const AssetImage(Assets.imagesHomeExer1), context);
    precacheImage(const AssetImage(Assets.imagesExercise), context);
    precacheImage(const AssetImage(Assets.imagesTrainer), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SearchExerciseBuilderWidget(),
          ExerciseTypeWidget(
            image: Assets.imagesHomeExer1,
            lable: S.of(context).home_exercises,
            onPressed: () {
              navigateTo(context, const HomeCategoryExercisesScreen());
            },
          ),
          const GymTypeBuilderWidget(),
          ExerciseTypeWidget(
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
