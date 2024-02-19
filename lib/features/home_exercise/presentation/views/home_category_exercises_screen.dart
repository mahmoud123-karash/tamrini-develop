import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/widgets/banner_ad_widget.dart';
import 'package:tamrini/features/home_exercise/presentation/views/widgets/home_category_exercise_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class HomeCategoryExercisesScreen extends StatelessWidget {
  const HomeCategoryExercisesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BannerAdWidget(),
      appBar: myAppBar(
        S.of(context).home_exercises,
      ),
      body: const HomeCategoryExerciseBuilderWidget(),
    );
  }
}
