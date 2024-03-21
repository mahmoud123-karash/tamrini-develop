import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainee/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/theme_cubit/theme_states.dart';
import 'package:tamrini/features/trainee/presentation/manager/user_course_cubit.dart/user_course_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/user_course_cubit.dart/user_course_states.dart';
import 'package:tamrini/features/trainee/presentation/views/widgets/user_course_content_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/course_theme_icon_widget.dart';

class TrainingCourseScreen extends StatefulWidget {
  const TrainingCourseScreen({super.key});

  @override
  State<TrainingCourseScreen> createState() => _TrainingCourseScreenState();
}

class _TrainingCourseScreenState extends State<TrainingCourseScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeStates>(
      builder: (context, state) {
        Color themeColor = ThemeCubit.get(context).themeColor;
        return Scaffold(
          appBar: themeAppBar(
            backgroundColor: themeColor,
            S.of(context).training_course,
            actions: [
              const CourseThemeIconWidget(),
            ],
          ),
          body: BlocBuilder<UserCourseCubit, UserCourseStates>(
            builder: (context, state) {
              if (state is SuccessGetCourseState) {
                return UserCourseContentWidget(
                  traineeModel: state.model,
                  themeColor: themeColor,
                );
              } else if (state is ErrorGetCourseState) {
                return Center(
                  child: GestureDetector(
                    onTap: () {
                      String trainerId =
                          CacheHelper.getData(key: 'trainerId') ?? '';
                      log(trainerId);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: Text(
                        state.message,
                        textAlign: TextAlign.center,
                      ),
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
      },
    );
  }
}
