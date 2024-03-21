import 'package:flutter/material.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_cubit.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_exercises_model.dart';

import 'day_name_row_widget.dart';
import 'exercise_item_widget.dart';

class DayCourseItemWidget extends StatelessWidget {
  const DayCourseItemWidget({
    super.key,
    required this.lable,
    required this.num,
    required this.list,
    required this.themeColor,
  });
  final String lable;
  final int num;
  final List<TraineeExerciseModel> list;
  final Color themeColor;

  @override
  Widget build(BuildContext context) {
    List<DataModel> exercises = [];
    for (var element in list) {
      DataModel? model = ExerciseCubit.get(context)
          .getExerciseData(dataId: element.exerciseId);
      if (model != null) {
        exercises.add(model);
      }
    }
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: list.isEmpty ? 50 : 300,
      child: Column(
        children: [
          DayNameRowWidget(lable: lable, num: num),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ExerciseItemWidget(
                model: exercises[index],
                width: width / 1.5,
                themeColor: themeColor,
                num: num,
              ),
              separatorBuilder: (context, index) => const SizedBox(
                width: 15,
              ),
              itemCount: exercises.length,
            ),
          )
        ],
      ),
    );
  }
}
