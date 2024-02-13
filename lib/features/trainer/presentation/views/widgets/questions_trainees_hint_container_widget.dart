import 'package:flutter/material.dart';
import 'package:tamrini/generated/l10n.dart';

class QuestionsTraineesHintContainerWidget extends StatelessWidget {
  const QuestionsTraineesHintContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.red.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.info_outline_rounded),
            Text(S.of(context).questions_trainee_hint),
          ],
        ),
      ),
    );
  }
}
