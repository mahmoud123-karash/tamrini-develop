import 'package:flutter/material.dart';
import 'package:tamrini/features/diet_food/data/models/diet_food_model.dart/diet_food_model.dart';
import 'package:tamrini/features/diet_food/presentation/views/widgets/diet_food_item_widget.dart';

class DietFoodListViewWidget extends StatelessWidget {
  const DietFoodListViewWidget(
      {super.key,
      required this.list,
      required this.length,
      required this.controller});
  final List<DietFoodModel> list;
  final int length;
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListView.separated(
        controller: controller,
        itemBuilder: (context, index) {
          if (index < length) {
            return DietFoodItemWidget(
              model: list[index],
            );
          } else {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 20,
        ),
        itemCount: list.length <= length ? list.length : length + 1,
      ),
    );
  }
}
