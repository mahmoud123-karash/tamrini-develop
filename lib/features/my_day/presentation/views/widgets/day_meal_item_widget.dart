import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/my_day/data/models/day_model/nutrient.dart';
import 'package:tamrini/features/my_day/presentation/manager/day_cubit/day_cubit.dart';

import '../../../../../generated/l10n.dart';
import 'day_row_value_lable_widget.dart';

class DayMealItemWidget extends StatelessWidget {
  const DayMealItemWidget({
    super.key,
    required this.name,
    required this.nutrient,
    required this.id,
  });
  final String name, id;
  final Nutrient nutrient;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        DayCubit.get(context).removeMeal(id: id, name: name, context: context);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 0.5,
          ),
          color: greyColor.withOpacity(0.1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyles.style14.copyWith(
                  fontWeight: FontWeight.w700,
                  color: appColor,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              DayRowValueLableWidget(
                value: nutrient.grams.toString(),
                lable: S.of(context).weight,
              ),
              DayRowValueLableWidget(
                value: nutrient.calories.toString(),
                lable: S.of(context).calories,
                isCalory: true,
              ),
              DayRowValueLableWidget(
                value: nutrient.protein.toString(),
                lable: S.of(context).protien,
              ),
              DayRowValueLableWidget(
                value: nutrient.fat.toString(),
                lable: S.of(context).fat,
              ),
              DayRowValueLableWidget(
                value: nutrient.carbs.toString(),
                lable: S.of(context).carb,
              )
            ],
          ),
        ),
      ),
    );
  }
}
