import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/trainee/presentation/manager/user_course_cubit.dart/user_course_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/user_course_cubit.dart/user_course_states.dart';
import 'package:tamrini/features/trainer/presentation/views/widgets/rating_trainer_colum_widget.dart';

class RatingTrainerBuilderWidget extends StatelessWidget {
  const RatingTrainerBuilderWidget({super.key, required this.trainerId});
  final String trainerId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCourseCubit, UserCourseStates>(
      builder: (context, state) {
        if (state is SuccessGetCourseState) {
          if (state.model.isRating) {
            return Container();
          } else {
            return RatingTrainerColumWidget(
              model: state.model,
              trainerId: trainerId,
            );
          }
        } else {
          return Container();
        }
      },
    );
  }
}
