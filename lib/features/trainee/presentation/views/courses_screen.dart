import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/course_model.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_states.dart';
import 'package:tamrini/features/trainee/presentation/views/new_course_screen.dart';
import 'package:tamrini/features/trainee/presentation/views/widgets/courses_list_view_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class CourcesScreen extends StatelessWidget {
  const CourcesScreen({super.key, required this.traineeId, this.list});
  final String traineeId;
  final List<CourseModel>? list;

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype');
    return Scaffold(
      appBar: myAppBar(S.of(context).courses),
      body: BlocBuilder<TraineeCubit, TraineeStates>(
        builder: (context, state) {
          TraineeModel? model = list != null
              ? null
              : TraineeCubit.get(context).getTrainee(id: traineeId);
          List<CourseModel> courses = list ?? model!.courses;
          return Column(
            children: [
              if (userType == 'trainer')
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: addCustomButton(
                    onPressed: () {
                      navigateTo(context, NewCourseScreen(model: model!));
                    },
                    lable: S.of(context).add_new_course,
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: courses.isEmpty
                    ? Center(
                        child: Text(
                          S.of(context).emptyList,
                        ),
                      )
                    : CoursesListViewWidget(list: courses),
              ),
            ],
          );
        },
      ),
    );
  }
}
