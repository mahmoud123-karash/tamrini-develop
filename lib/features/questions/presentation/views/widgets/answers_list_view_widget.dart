import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/generated/l10n.dart';

import 'answer_item_builder_widget.dart';

class AnswerslistViewWidget extends StatelessWidget {
  const AnswerslistViewWidget(
      {super.key, required this.question, required this.scrolController});
  final QuestionModel question;
  final ScrollController scrolController;

  @override
  Widget build(BuildContext context) {
    return question.answers.isEmpty
        ? Center(
            child: SizedBox(
              height: 50,
              child: Text(S.of(context).no_answers),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(bottom: 80, top: 10),
            child: ListView.separated(
              controller: scrolController,
              reverse: true,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return AnswerItemBuilderWidget(
                  model: question.answers[index],
                  question: question,
                );
              },
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 25,
                ),
                child: Container(
                  width: double.infinity,
                  height: 0.1,
                  color: blackColor,
                ),
              ),
              itemCount: question.answers.length,
            ),
          );
  }
}
