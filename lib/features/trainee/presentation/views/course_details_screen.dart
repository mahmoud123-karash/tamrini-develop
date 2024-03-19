import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/lists.dart';
import 'package:tamrini/core/widgets/circlar_image_widget.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/course_model.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_exercises_model.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/course_name_row_widget.dart';
import 'widgets/course_notes_container_widget.dart';
import 'widgets/day_week_container_widget.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen(
      {super.key, required this.model, required this.logo});
  final CourseModel model;
  final String logo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).course_details),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CirclarImageWidget(
                  image: logo,
                  radius: 50,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CourseNameRowWidget(
                value: model.title,
                lable: S.of(context).course_name,
                icon: Icons.title,
              ),
              const SizedBox(
                height: 10,
              ),
              CourseNameRowWidget(
                value: "${model.duration} ${S.of(context).weeks}",
                lable: S.of(context).duration_course,
                icon: Icons.timelapse_outlined,
              ),
              const SizedBox(
                height: 10,
              ),
              CourseNameRowWidget(
                value:
                    DateFormat('M/d/y', 'en').format(model.createdAt.toDate()),
                lable: S.of(context).course_date,
                icon: Icons.calendar_month_outlined,
              ),
              if (model.notes != '')
                const SizedBox(
                  height: 25,
                ),
              if (model.notes != '')
                CourseNotesContainerWidget(notes: model.notes),
              const SizedBox(
                height: 25,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => DayWeekContainerWidget(
                  lable: daysWeek(context)[index],
                  list: getList(index, model.dayWeekExercises),
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: 7,
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<TraineeExerciseModel> getList(int index, DayWeekExercises model) {
  switch (index) {
    case 0:
      return model.sat ?? [];
    case 1:
      return model.sun ?? [];
    case 2:
      return model.mon ?? [];
    case 3:
      return model.tue ?? [];
    case 4:
      return model.wed ?? [];
    case 5:
      return model.thurs ?? [];
    case 6:
      return model.fri ?? [];

    default:
      return [];
  }
}
