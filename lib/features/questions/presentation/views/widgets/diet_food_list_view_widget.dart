import 'package:flutter/material.dart';
import 'package:tamrini/features/questions/data/models/diet_food_model.dart/diet_food_model.dart';
import 'package:tamrini/features/questions/presentation/views/widgets/diet_food_item_widget.dart';

class DietFoodListViewWidget extends StatelessWidget {
  const DietFoodListViewWidget(
      {super.key, required this.list, required this.length});
  final List<DietFoodModel> list;
  final int length;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
      itemCount: list.length < length ? list.length : length + 1,
    );
  }
}
