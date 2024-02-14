import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

class FollowDetailsItemWidget extends StatelessWidget {
  const FollowDetailsItemWidget(
      {super.key, required this.question, required this.answer});
  final String question, answer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${S.of(context).question}: $question؟",
          style: TextStyles.style16Bold.copyWith(
            color: appColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "${S.of(context).answer}: $answer.",
        )
      ],
    );
  }
}
