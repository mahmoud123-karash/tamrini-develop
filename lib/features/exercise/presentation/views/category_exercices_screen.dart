import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/exercise/presentation/views/new_section_screen.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/all_exercises_container_widget.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/category_grid_view_widget.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_cubit.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_states.dart';
import 'package:tamrini/features/trainee/presentation/manager/course_cubit/course_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

import 'all_exercises_category_screen.dart';

class CategoryExercisesScreen extends StatelessWidget {
  const CategoryExercisesScreen({
    Key? key,
    this.isCourse = false,
  }) : super(key: key);
  final bool isCourse;

  @override
  Widget build(BuildContext context) {
    CourseCubit.get(context).list.clear();
    String userType = CacheHelper.getData(key: 'usertype');

    return Scaffold(
      appBar: myAppBar(
        S.of(context).categoryEx,
      ),
      body: BlocBuilder<ExerciseCubit, ExerciseStates>(
        builder: (context, state) {
          if (state is SucessGetExerciseState) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (userType == 'admin')
                      addCustomButton(
                        onPressed: () {
                          navigateTo(context, const NewSectionScreen());
                        },
                        lable: S.of(context).add_new_section,
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    AllExercisesContainerWidget(
                      onPressed: () {
                        List<DataModel> exercises = [];
                        for (var element in state.exercises) {
                          exercises.addAll(element.data!);
                        }
                        if (exercises.isNotEmpty) {
                          navigateTo(
                            context,
                            AllExercisesCategoryScreen(
                              list: exercises,
                              title: S.of(context).allEx,
                              isAll: true,
                              isCourse: isCourse,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CategoryGridViewWidget(
                        models: state.exercises, isCourse: isCourse),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
