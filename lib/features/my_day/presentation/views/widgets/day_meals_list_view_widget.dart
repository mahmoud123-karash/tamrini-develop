import 'package:flutter/material.dart';

import 'day_meal_item_widget.dart';

class DayMealsListViewWidget extends StatelessWidget {
  const DayMealsListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => const DayMealItemWidget(),
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
      itemCount: 15,
    );
  }
}
