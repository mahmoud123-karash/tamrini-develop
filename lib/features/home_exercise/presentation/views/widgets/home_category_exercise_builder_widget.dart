import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/home_exercise/presentation/manager/home_exercise_cubit/home_exercise_cubit.dart';
import 'package:tamrini/features/home_exercise/presentation/manager/home_exercise_cubit/home_exercise_states.dart';
import 'package:tamrini/features/home_exercise/presentation/views/all_home_exercise_category_screen.dart';
import 'package:tamrini/features/exercise/presentation/views/widgets/all_exercises_container_widget.dart';
import 'package:tamrini/features/home_exercise/presentation/views/new_home_section_screen.dart';
import 'package:tamrini/features/home_exercise/presentation/views/widgets/home_category_grid_view_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../data/models/home_exercise/exercise_data.dart';

class HomeCategoryExerciseBuilderWidget extends StatelessWidget {
  const HomeCategoryExerciseBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype');

    return BlocBuilder<HomeExerciseCubit, HomeExersiceStates>(
      builder: (context, state) {
        if (state is SucessGetHomeExerciseState) {
          if (state.list.isEmpty) {
            return Container();
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (userType == 'admin')
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: addCustomButton(
                          onPressed: () {
                            navigateTo(context, const NewHomeSectionScreen());
                          },
                          lable: S.of(context).add_new_section,
                        ),
                      ),
                    const SizedBox(
                      height: 5,
                    ),
                    AllExercisesContainerWidget(
                      onPressed: () {
                        List<Data> list = [];
                        for (var element in state.list) {
                          list.addAll(element.data!);
                        }
                        if (list.isNotEmpty) {
                          navigateTo(
                            context,
                            AllHomeExercisesCategoryScreen(
                              models: list,
                              title: S.of(context).home_exercises,
                              isAll: true,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    HomeCategoryGridViewWidget(models: state.list),
                  ],
                ),
              ),
            );
          }
        } else if (state is ErrorGetHomeExerciseState) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                state.message,
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
