import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

class QuestionFieldItemWidget extends StatelessWidget {
  const QuestionFieldItemWidget({
    super.key,
    required this.question,
    required this.autovalidateMode,
    required this.controller,
    required this.themeColor,
  });
  final String question;
  final TextEditingController controller;
  final AutovalidateMode autovalidateMode;
  final Color themeColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$question ؟',
          style: TextStyles.style14.copyWith(
            color: themeColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        themeTextField(
          color: themeColor,
          lable: S.of(context).answer_question,
          controller: controller,
          context: context,
          autovalidateMode: autovalidateMode,
        )
      ],
    );
  }
}
