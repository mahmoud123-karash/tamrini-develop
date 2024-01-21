import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/my_day/data/models/day_model/nutrient.dart';
import 'package:tamrini/generated/l10n.dart';

import 'day_meals_list_view_widget.dart';

class DayMealsContainerWidget extends StatelessWidget {
  const DayMealsContainerWidget({super.key, required this.map});
  final Map<String, Nutrient> map;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: appColor, width: 0.5),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).your_meals,
              style: TextStyles.style17.copyWith(
                fontWeight: FontWeight.bold,
                color: appColor,
              ),
            ),
            Text(
              '\'${S.of(context).scroll_verticle_to_remove}\'',
              style: TextStyles.style12.copyWith(),
            ),
            const SizedBox(
              height: 15,
            ),
            if (map.isEmpty)
              Center(
                child: Text(S.of(context).no_meals),
              ),
            DayMealsListViewWidget(map: map),
          ],
        ),
      ),
    );
  }
}
