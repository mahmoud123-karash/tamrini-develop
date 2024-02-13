import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainee/presentation/manager/user_course_cubit.dart/user_course_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/user_course_cubit.dart/user_course_states.dart';
import 'package:tamrini/generated/l10n.dart';

class AddFollowCustomWidget extends StatelessWidget {
  const AddFollowCustomWidget(
      {super.key, required this.onPressed, required this.lable});
  final VoidCallback onPressed;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCourseCubit, UserCourseStates>(
      listener: (context, state) {
        if (state is ErrorGetCourseState) {
          showSnackBar(context, state.message);
          UserCourseCubit.get(context).getCourse();
        }

        if (state is SuccessGetCourseState) {
          Navigator.pop(context);
          showSnackBar(context, S.of(context).success_add_a);
        }
      },
      builder: (context, state) {
        if (state is LoadingGetCourseState) {
          return const CircularProgressIndicator();
        } else {
          return customButton(onPressed: onPressed, lable: lable);
        }
      },
    );
  }
}
