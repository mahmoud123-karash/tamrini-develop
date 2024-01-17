import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';

import '../../../../generated/l10n.dart';
import 'widgets/nutrition_classification_list_view_builder_widget.dart';

class NutritionClassificationScreen extends StatelessWidget {
  const NutritionClassificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).values_food),
      body: const NutritionClassificationListViewBuilderWidget(),
    );
  }
}
