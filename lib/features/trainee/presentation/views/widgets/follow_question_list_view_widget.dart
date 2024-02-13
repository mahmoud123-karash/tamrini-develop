import 'package:flutter/material.dart';
import 'package:tamrini/features/trainee/presentation/views/widgets/question_field_item_widget.dart';

class FollowQuestionListViewWidget extends StatelessWidget {
  const FollowQuestionListViewWidget(
      {super.key,
      required this.questions,
      required this.controllers,
      required this.autovalidateMode});
  final List<String> questions;
  final List<TextEditingController> controllers;
  final AutovalidateMode autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return QuestionFieldItemWidget(
          question: questions[index],
          autovalidateMode: autovalidateMode,
          controller: controllers[index],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
      itemCount: questions.length,
    );
  }
}
