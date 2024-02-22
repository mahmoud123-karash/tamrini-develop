import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/widgets/banner_ad_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/trainer_content_builder_widget.dart';

class TrainersScreen extends StatelessWidget {
  const TrainersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BannerAdWidget(),
      appBar: myAppBar(S.of(context).trainersPage),
      body: const TrainerContentBuilderWidget(),
    );
  }
}
