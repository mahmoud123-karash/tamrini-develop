import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/generated/l10n.dart';

import 'answer_item_builder_widget.dart';
import 'answer_loading_item_widget.dart';

class AnswerslistViewWidget extends StatefulWidget {
  const AnswerslistViewWidget(
      {super.key, required this.length, required this.question});
  final int length;
  final QuestionModel question;

  @override
  State<AnswerslistViewWidget> createState() => _AnswerslistViewWidgetState();
}

class _AnswerslistViewWidgetState extends State<AnswerslistViewWidget> {
  bool showWidget = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          showWidget = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.question.answers.sort((a, b) => b.date.compareTo(a.date));
    return widget.question.answers.isEmpty
        ? Center(
            child: SizedBox(
              height: 50,
              child: Text(S.of(context).no_answers),
            ),
          )
        : !showWidget
            ? const AnswerLoadingItemWidgt()
            : Padding(
                padding: const EdgeInsets.only(bottom: 80, top: 10),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index < widget.length) {
                      return AnswerItemBuilderWidget(
                        model: widget.question.answers[index],
                        question: widget.question,
                      );
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
                  itemCount: widget.question.answers.length <= widget.length
                      ? widget.question.answers.length
                      : widget.length + 1,
                ),
              );
  }
}
