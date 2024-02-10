import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/features/trainer/presentation/views/widgets/sub_button_with_trainer_widget.dart';
import 'package:tamrini/features/trainer/presentation/views/widgets/trainer_content_widget.dart';

import 'package:tamrini/generated/l10n.dart';

class TrainerProfileScreen extends StatelessWidget {
  const TrainerProfileScreen({Key? key, required this.trainer})
      : super(key: key);
  final TrainerModel trainer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).trainer_profile),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: TrainerContentWidget(trainer: trainer),
          ),
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SubButtonWithTrainerWidget(),
            ),
          )
        ],
      ),
    );
  }
}
