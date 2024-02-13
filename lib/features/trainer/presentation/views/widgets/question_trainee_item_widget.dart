import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/generated/l10n.dart';

import 'remove_question_trainee_custom_widget.dart';

class QuestionTraineeItemWidget extends StatelessWidget {
  const QuestionTraineeItemWidget({
    super.key,
    required this.index,
    required this.question,
    required this.model,
  });
  final int index;
  final String question;
  final TrainerModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: greyColor.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${S.of(context).question}${index + 1}',
                  style: TextStyles.style16Bold.copyWith(
                    color: appColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  '$question؟',
                  style: TextStyles.style14.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            const Spacer(),
            RemoveQuestionTraineeCustomWidget(question: question, model: model)
          ],
        ),
      ),
    );
  }
}
