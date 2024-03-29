import 'package:flutter/material.dart';
import 'package:tamrini/features/nutrition/data/models/nutrition_model/classification_model.dart';
import 'package:tamrini/features/nutrition/presentation/views/widgets/nutrition_classification_item_widget.dart';

class NutritionClassificationListViewWidget extends StatelessWidget {
  const NutritionClassificationListViewWidget(
      {super.key, required this.list, required this.isMyday, required this.id});
  final List<ClassificationModel> list;
  final bool isMyday;
  final String id;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => NutritionClassificationItemWidget(
        model: list[index],
        isMyday: isMyday,
        id: id,
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: 5,
      ),
      itemCount: list.length,
    );
  }
}
