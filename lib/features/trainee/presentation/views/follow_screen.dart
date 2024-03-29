import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';

import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/core/widgets/circlar_image_widget.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/features/trainee/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/theme_cubit/theme_states.dart';
import 'package:tamrini/features/trainee/presentation/manager/user_course_cubit.dart/user_course_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/user_course_cubit.dart/user_course_states.dart';
import 'package:tamrini/features/trainee/presentation/views/new_follow_screen.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/follow_up_list_view_widget.dart';

class FollowScreen extends StatelessWidget {
  const FollowScreen(
      {super.key, this.questions, required this.model, required this.logo});
  final List<String>? questions;
  final TraineeModel model;
  final String logo;

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype') ?? "";
    return BlocBuilder<ThemeCubit, ThemeStates>(
      builder: (context, state) {
        Color themeColor = ThemeCubit.get(context).themeColor;
        return Scaffold(
          appBar: themeAppBar(
            S.of(context).follow_and_data,
            backgroundColor: themeColor,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Column(
              children: [
                if (userType != UserType.trainer)
                  addCustomButton(
                    color: themeColor,
                    fontSize: 15,
                    onPressed: () {
                      navigateTo(
                        context,
                        NewFollowScreen(
                          logo: logo,
                          questions: questions ?? [],
                          model: model,
                        ),
                      );
                    },
                    lable: S.of(context).add_new_follow,
                  ),
                if (userType == UserType.trainer)
                  if (logo != '') CirclarImageWidget(image: logo, radius: 50),
                const SizedBox(
                  height: 15,
                ),
                if (userType == UserType.trainer)
                  FollowUpListViewWidget(
                    list: model.followUpList,
                    themeColor: themeColor,
                  ),
                if (userType != UserType.trainer)
                  BlocBuilder<UserCourseCubit, UserCourseStates>(
                    builder: (context, state) {
                      if (state is SuccessGetCourseState) {
                        return FollowUpListViewWidget(
                          list: state.model.followUpList,
                          themeColor: themeColor,
                        );
                      } else if (state is ErrorGetCourseState) {
                        return Center(
                          child: Text(
                            state.message,
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
