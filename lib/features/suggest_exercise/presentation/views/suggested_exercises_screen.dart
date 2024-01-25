import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/suggested_list_view_builder_widget.dart';

class SuggestedExerciseScreen extends StatelessWidget {
  const SuggestedExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        S.of(context).suggested_exercises,
      ),
      body: const SuggestedListViewBuilderWidget(),
    );
  }
}
