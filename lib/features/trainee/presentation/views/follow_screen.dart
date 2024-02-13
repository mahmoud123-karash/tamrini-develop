import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/shared_preference.dart';

import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/follow_up_model.dart';
import 'package:tamrini/features/trainee/presentation/manager/user_course_cubit.dart/user_course_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/user_course_cubit.dart/user_course_states.dart';
import 'package:tamrini/features/trainee/presentation/views/new_follow_screen.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/follow_up_list_view_widget.dart';

class FollowScreen extends StatelessWidget {
  const FollowScreen({super.key, required this.list, this.questions});
  final List<FollowUpModel> list;
  final List<String>? questions;

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype');
    return Scaffold(
      appBar: myAppBar(S.of(context).follow_and_data),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Column(
          children: [
            if (userType != 'trainer')
              addCustomButton(
                fontSize: 15,
                onPressed: () {
                  navigateTo(
                      context, NewFollowScreen(questions: questions ?? []));
                },
                lable: S.of(context).add_new_follow,
              ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<UserCourseCubit, UserCourseStates>(
              builder: (context, state) {
                if (state is SuccessGetCourseState) {
                  return FollowUpListViewWidget(list: state.model.followUpList);
                } else {
                  return FollowUpListViewWidget(list: list);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
