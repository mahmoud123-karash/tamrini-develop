import 'package:flutter/material.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_cubit.dart';

import 'day_name_row_widget.dart';
import 'exercise_item_widget.dart';

class DayCourseItemWidget extends StatelessWidget {
  const DayCourseItemWidget(
      {super.key, required this.lable, required this.num});
  final String lable;
  final int num;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          DayNameRowWidget(lable: lable, num: num),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ExerciseItemWidget(
                model: ExerciseCubit.get(context)
                    .getExerciseData(dataId: '0sSTWoNpOydiovJicfa5661'),
              ),
              separatorBuilder: (context, index) => const SizedBox(
                width: 15,
              ),
              itemCount: 10,
            ),
          )
        ],
      ),
    );
  }
}
