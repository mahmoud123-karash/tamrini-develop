import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/lists.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/food_model.dart';
import 'package:tamrini/features/trainee/presentation/views/widgets/day_data_colum_item_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/diet_course_date_and_naem_row_widget.dart';

class DietCourseDetailsScreen extends StatelessWidget {
  const DietCourseDetailsScreen({super.key, required this.food});
  final FoodModel food;

  @override
  Widget build(BuildContext context) {
    List<String> daysData = [];
    daysData.add(food.satData);
    daysData.add(food.sunData);
    daysData.add(food.monData);
    daysData.add(food.tueData);
    daysData.add(food.wedData);
    daysData.add(food.thursData);
    daysData.add(food.friData);
    return Scaffold(
      appBar: myAppBar(S.of(context).diet_course_details),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: Column(
                children: [
                  DietCourseDateAndNameRowWidget(
                    title: food.title,
                    createdAt: food.createdAt,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => DayDataColumItemWidget(
                      day: daysWeek(context)[index],
                      data: daysData[index],
                    ),
                    separatorBuilder: (context, index) => const Divider(
                      height: 50,
                    ),
                    itemCount: daysWeek(context).length,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
