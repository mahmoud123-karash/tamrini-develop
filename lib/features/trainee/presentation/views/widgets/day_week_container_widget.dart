import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_cubit.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_exercises_model.dart';

import '../exercises_courses_screen.dart';

class DayWeekContainerWidget extends StatelessWidget {
  const DayWeekContainerWidget(
      {super.key, required this.lable, required this.list});
  final String lable;
  final List<TraineeExerciseModel> list;
  @override
  Widget build(BuildContext context) {
    List<DataModel> dataList = [];
    for (var element in list) {
      DataModel? model = ExerciseCubit.get(context)
          .getExerciseData(dataId: element.exerciseId);
      if (model != null) {
        dataList.add(model);
      }
    }
    return ListTile(
      onTap: () {
        navigateTo(
            context, ExerciseCoursesScreen(dayName: lable, list: dataList));
      },
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      tileColor: appColor.withOpacity(0.4),
      leading: const Icon(Icons.calendar_month_rounded),
      title: Text(
        lable,
        style: TextStyles.style14.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
      ),
    );
  }
}
