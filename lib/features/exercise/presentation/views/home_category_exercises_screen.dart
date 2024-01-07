import 'package:flutter/material.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/home_category_exercise_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class HomeCategoryExercisesScreen extends StatelessWidget {
  const HomeCategoryExercisesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).home_exercises),
        centerTitle: true,
      ),
      body: const HomeCategoryExerciseBuilderWidget(),
    );
  }
}
