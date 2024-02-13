import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainee/presentation/manager/user_course_cubit.dart/user_course_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/user_course_cubit.dart/user_course_states.dart';
import 'package:tamrini/features/trainee/presentation/views/widgets/user_course_content_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class TrainingCourseScreen extends StatelessWidget {
  const TrainingCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).training_course),
      body: BlocBuilder<UserCourseCubit, UserCourseStates>(
        builder: (context, state) {
          if (state is SuccessGetCourseState) {
            return UserCourseContentWidget(traineeModel: state.model);
          } else if (state is ErrorGetCourseState) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
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
      ),
    );
  }
}
