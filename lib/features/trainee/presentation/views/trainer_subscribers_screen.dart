import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/trainee_content_buider_widget.dart';

class TrainerSubscribersScreen extends StatelessWidget {
  const TrainerSubscribersScreen({super.key, required this.logo});
  final String logo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).subcribers),
      body: TraineeContentBuilderWidget(
        logo: logo,
      ),
    );
  }
}
