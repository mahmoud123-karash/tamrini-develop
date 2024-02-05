import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/exercise_data.dart';
import 'package:tamrini/features/home_exercise/presentation/manager/home_exercise_cubit/home_exercise_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class RemoveHomeExerciseIconWidget extends StatelessWidget {
  const RemoveHomeExerciseIconWidget({
    super.key,
    required this.model,
  });
  final Data model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        onPressed: () {
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
            title: model.title,
            desc: S.of(context).remove_exercise_question,
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              HomeExerciseCubit.get(context).removeExercise(
                oldData: model,
                id: model.sectionId ?? '',
                message: S.of(context).success_remove,
              );
            },
          ).show();
        },
        icon: const Icon(Icons.delete),
        color: Colors.red,
      ),
    );
  }
}
