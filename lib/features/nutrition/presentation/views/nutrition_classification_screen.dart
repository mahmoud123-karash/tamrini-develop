import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/nutrition/presentation/views/widgets/new_classification_dialog_widget.dart';

import '../../../../generated/l10n.dart';
import 'widgets/nutrition_classification_list_view_builder_widget.dart';

class NutritionClassificationScreen extends StatelessWidget {
  const NutritionClassificationScreen(
      {super.key, this.isMyday = false, this.id = ''});
  final bool isMyday;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).values_food),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: addCustomButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const NewClassificationDialogWidget(),
                );
              },
              lable: S.of(context).add_nutrition_classification,
            ),
          ),
          Expanded(
            child: NutritionClassificationListViewBuilderWidget(
              isMyday: isMyday,
              id: id,
            ),
          ),
        ],
      ),
    );
  }
}
