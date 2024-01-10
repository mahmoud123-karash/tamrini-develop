import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/questions/data/models/question_model/answer_model.dart';
import 'package:tamrini/generated/l10n.dart';

import 'answer_item_builder_widget.dart';

class AnswerslistViewWidget extends StatelessWidget {
  const AnswerslistViewWidget(
      {super.key, required this.list, required this.length});
  final List<AnswerModel> list;
  final int length;

  @override
  Widget build(BuildContext context) {
    list.sort((a, b) => b.date.compareTo(a.date));
    return list.isEmpty
        ? Center(
            child: SizedBox(
              height: 50,
              child: Text(S.of(context).no_answers),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(bottom: 80, top: 10),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (index < length) {
                  return AnswerItemBuilderWidget(model: list[index]);
                } else {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
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
              itemCount: list.length < length ? list.length : length + 1,
            ),
          );
  }
}
