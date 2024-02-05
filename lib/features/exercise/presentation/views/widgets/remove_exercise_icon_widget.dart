import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../data/models/exercise_model/data_model.dart';

class RemoveExerciseIconWidget extends StatelessWidget {
  const RemoveExerciseIconWidget(
      {super.key, required this.model, required this.id});
  final DataModel model;
  final String id;

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
            title: model.title ?? '',
            desc: S.of(context).remove_exercise_question,
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              ExerciseCubit.get(context).removeExercise(
                exerciseId: CacheHelper.getData(key: 'exerciseId') ?? '',
                oldData: model,
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
