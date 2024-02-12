import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/exercise/presentation/views/category_exercices_screen.dart';
import 'package:tamrini/features/trainee/presentation/manager/course_cubit/course_cubit.dart';

class DayNameRowWidget extends StatelessWidget {
  const DayNameRowWidget({super.key, required this.lable, required this.num});
  final String lable;
  final int num;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          lable,
          style: TextStyles.style16Bold.copyWith(
            color: appColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            CourseCubit.get(context).num = num;
            navigateTo(
              context,
              const CategoryExercisesScreen(
                isCourse: true,
              ),
            );
          },
          icon: Icon(
            Icons.add_box_rounded,
            color: appColor,
          ),
        )
      ],
    );
  }
}
