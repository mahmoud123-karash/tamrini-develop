import 'package:flutter/material.dart';
import 'package:tamrini/features/my_day/data/models/day_model/nutrient.dart';

import 'day_meal_item_widget.dart';

class DayMealsListViewWidget extends StatelessWidget {
  const DayMealsListViewWidget(
      {super.key, required this.map, required this.id});
  final Map<String, Nutrient> map;
  final String id;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => DayMealItemWidget(
        name: map.keys.toList()[index],
        nutrient: map.values.toList()[index],
        id: id,
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
      itemCount: map.length,
    );
  }
}
