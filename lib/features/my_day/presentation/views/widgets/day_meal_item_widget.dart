import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';

import '../../../../../generated/l10n.dart';
import 'day_row_value_lable_widget.dart';

class DayMealItemWidget extends StatelessWidget {
  const DayMealItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
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
                'meal name',
                style: TextStyles.style14.copyWith(
                  fontWeight: FontWeight.w700,
                  color: appColor,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              DayRowValueLableWidget(
                value: '10.25',
                lable: S.of(context).weight,
              ),
              DayRowValueLableWidget(
                value: '10.25',
                lable: S.of(context).calories,
                isCalory: true,
              ),
              DayRowValueLableWidget(
                value: '10.25',
                lable: S.of(context).protien,
              ),
              DayRowValueLableWidget(
                value: '10.25',
                lable: S.of(context).fat,
              ),
              DayRowValueLableWidget(
                value: '10.25',
                lable: S.of(context).carb,
              )
            ],
          ),
        ),
      ),
    );
  }
}
