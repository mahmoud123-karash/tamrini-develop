import 'package:flutter/material.dart';
import 'package:tamrini/features/food/data/models/nutrition_model/classification_model.dart';
import 'package:tamrini/features/food/presentation/views/widgets/nutrition_classification_item_widget.dart';

class NutritionClassificationListViewWidget extends StatelessWidget {
  const NutritionClassificationListViewWidget({super.key, required this.list});
  final List<ClassificationModel> list;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) =>
          NutritionClassificationItemWidget(model: list[index]),
      separatorBuilder: (context, index) => const SizedBox(
        height: 5,
      ),
      itemCount: list.length,
    );
  }
}
