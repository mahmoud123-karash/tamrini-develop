import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/utils/lists.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_exercises_model.dart';
import 'package:tamrini/features/trainee/presentation/manager/course_cubit/course_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/course_cubit/course_states.dart';

import 'day_course_item_widget.dart';

class DaysCourseWidget extends StatefulWidget {
  const DaysCourseWidget({super.key, required this.themeColor});
  final Color themeColor;

  @override
  State<DaysCourseWidget> createState() => _DaysCourseWidgetState();
}

class _DaysCourseWidgetState extends State<DaysCourseWidget> {
  @override
  void initState() {
    CourseCubit.get(context).sutList.clear();
    CourseCubit.get(context).sunList.clear();
    CourseCubit.get(context).monList.clear();
    CourseCubit.get(context).tueList.clear();
    CourseCubit.get(context).wenList.clear();
    CourseCubit.get(context).thrueList.clear();
    CourseCubit.get(context).friList.clear();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCubit, CourseStates>(
      builder: (context, state) {
        var cubit = CourseCubit.get(context);
        List<List<TraineeExerciseModel>> list = [
          cubit.sutList,
          cubit.sunList,
          cubit.monList,
          cubit.tueList,
          cubit.wenList,
          cubit.thrueList,
          cubit.friList,
        ];
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: daysWeek(context).length,
            itemBuilder: (context, index) {
              return DayCourseItemWidget(
                themeColor:widget.themeColor,
                lable: daysWeek(context)[index],
                num: index,
                list: list[index],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
          ),
        );
      },
    );
  }
}
