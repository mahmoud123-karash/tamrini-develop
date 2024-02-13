import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/food_model.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class RemoveDietCourseWidget extends StatelessWidget {
  const RemoveDietCourseWidget(
      {super.key, required this.model, required this.food});
  final FoodModel food;
  final TraineeModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AwesomeDialog(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          showCloseIcon: true,
          titleTextStyle: TextStyles.style17.copyWith(
            fontWeight: FontWeight.bold,
            color: appColor,
          ),
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.bottomSlide,
          title: food.title,
          desc: S.of(context).remove_diet_question,
          btnCancelOnPress: () {},
          btnOkOnPress: () {
            TraineeCubit.get(context).removeDietCourse(
              model: model,
              foodModel: food,
            );
          },
        ).show();
      },
      child: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
    );
  }
}
