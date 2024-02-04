import 'package:flutter/material.dart';
import 'package:tamrini/features/food/presentation/views/widgets/choose_meal_container_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class NutritionButtonsRowWidget extends StatelessWidget {
  const NutritionButtonsRowWidget({
    super.key,
    required this.onPressedOne,
    required this.onPressedTwo,
  });

  final VoidCallback onPressedOne;
  final VoidCallback onPressedTwo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ChooseMealContainerWidget(
            onPressed: onPressedOne,
            text: S.of(context).choose_meal,
          ),
          ChooseMealContainerWidget(
            onPressed: onPressedTwo,
            text: S.of(context).choose_weight,
          ),
        ],
      ),
    );
  }
}
