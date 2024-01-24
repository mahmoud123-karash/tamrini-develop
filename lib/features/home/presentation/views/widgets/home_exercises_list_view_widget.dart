import 'package:flutter/material.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_exercise_item_widget.dart';

class ExercisesListViewWidget extends StatelessWidget {
  const ExercisesListViewWidget({super.key, required this.exercises});
  final List<DataModel> exercises;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getHeight = mediaQuery.size.height;
    return SizedBox(
      height: getHeight * 0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: exercises.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return HomeExerciseItemWidget(
            model: exercises[index],
          );
        },
      ),
    );
  }
}
