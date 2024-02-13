import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainer/presentation/views/trainer_gallery_screen.dart';
import 'package:tamrini/generated/l10n.dart';

import '../questions_trainee_screen.dart';

class TrainerButtonsRowWidget extends StatelessWidget {
  const TrainerButtonsRowWidget({super.key, required this.trainerId});
  final String trainerId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: addCustomButton(
              icon: Icons.image_outlined,
              fontSize: 13,
              onPressed: () {
                navigateTo(context, TrainerGallerySreen(id: trainerId));
              },
              lable: S.of(context).trainer_gallery,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: addCustomButton(
              icon: Icons.question_answer_outlined,
              fontSize: 13,
              onPressed: () {
                navigateTo(
                    context, QuestionsTraineeScreen(trainerId: trainerId));
              },
              lable: S.of(context).questions_trainee,
            ),
          ),
        ],
      ),
    );
  }
}
