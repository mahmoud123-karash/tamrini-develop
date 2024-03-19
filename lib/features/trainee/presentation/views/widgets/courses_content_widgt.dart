import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/core/widgets/circlar_image_widget.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/course_model.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/features/trainee/presentation/views/new_course_screen.dart';
import 'package:tamrini/generated/l10n.dart';

import 'courses_list_view_widget.dart';

class CoursesContentWidget extends StatelessWidget {
  const CoursesContentWidget({
    super.key,
    required this.courses,
    required this.model,
    required this.length,
    required this.logo,
  });
  final List<CourseModel> courses;
  final TraineeModel? model;
  final int length;
  final String logo;

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype') ?? '';
    return Column(
      children: [
        if (userType == UserType.trainer)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: addCustomButton(
              onPressed: () {
                navigateTo(
                    context,
                    NewCourseScreen(
                      model: model!,
                      logo: logo,
                    ));
              },
              lable: S.of(context).add_new_course,
            ),
          ),
        const SizedBox(
          height: 10,
        ),
        if (userType != UserType.trainer)
          CirclarImageWidget(
            image: logo,
            radius: 50,
          ),
        if (userType != UserType.trainer)
          const SizedBox(
            height: 15,
          ),
        Expanded(
          child: courses.isEmpty
              ? Center(
                  child: Text(
                    S.of(context).no_results,
                  ),
                )
              : CoursesListViewWidget(
                  list: courses,
                  length: length,
                  logo: logo,
                ),
        ),
      ],
    );
  }
}
