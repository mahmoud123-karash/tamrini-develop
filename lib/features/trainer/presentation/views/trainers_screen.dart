import 'package:flutter/material.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/trainer_content_builder_widget.dart';

class TrainersScreen extends StatelessWidget {
  const TrainersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).trainersPage),
        centerTitle: true,
      ),
      body: const TrainerContentBuilderWidget(),
    );
  }
}