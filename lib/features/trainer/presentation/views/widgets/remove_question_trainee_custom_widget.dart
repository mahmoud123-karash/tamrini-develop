import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class RemoveQuestionTraineeCustomWidget extends StatelessWidget {
  const RemoveQuestionTraineeCustomWidget(
      {super.key, required this.question, required this.model});
  final String question;
  final TrainerModel model;

  @override
  Widget build(BuildContext context) {
    return IconButton(
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
          title: question,
          desc: S.of(context).question_remove_question,
          btnCancelOnPress: () {},
          btnOkOnPress: () {
            TrainersCubit.get(context).removeQuestion(
              trainer: model,
              question: question,
            );
          },
        ).show();
      },
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
    );
  }
}
