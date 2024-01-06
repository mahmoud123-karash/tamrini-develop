import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/home/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/home/data/models/exercise_model/exercise_model.dart';
import 'package:tamrini/features/exercise/presentation/views/search_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class AllExercisesContainerWidget extends StatelessWidget {
  const AllExercisesContainerWidget({super.key, required this.models});
  final List<ExerciseModel> models;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        List<DataModel> exercises = [];
        for (var element in models) {
          exercises.addAll(element.data!);
        }
        if (exercises.isNotEmpty) {
          navigateTo(context, SearchScreen(exercises: exercises));
        }
      },
      child: Container(
        alignment: Alignment.topRight,
        constraints: BoxConstraints(
          minHeight: 100.spMax,
          minWidth: 100,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: const DecorationImage(
            image: AssetImage("assets/images/allExer.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            S.of(context).allEx,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
