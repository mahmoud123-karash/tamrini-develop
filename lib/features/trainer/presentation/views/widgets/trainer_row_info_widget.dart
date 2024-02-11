import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/features/trainer/presentation/views/widgets/trainer_info_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class TrainerRowInfoWIdget extends StatelessWidget {
  const TrainerRowInfoWIdget({super.key, required this.trainer});
  final TrainerModel trainer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        children: [
          TrainerInfoWidget(
            icon: Ionicons.people,
            value: trainer.traineesCount.toString(),
            text: S.of(context).trainee,
          ),
          const Spacer(),
          TrainerInfoWidget(
            icon: Ionicons.star,
            value: trainer.rating!.toStringAsFixed(1),
            text: S.of(context).rating,
          ),
          const Spacer(),
          TrainerInfoWidget(
            icon: Icons.attach_money_outlined,
            value: trainer.price.toString(),
            text: S.of(context).money,
          )
        ],
      ),
    );
  }
}
