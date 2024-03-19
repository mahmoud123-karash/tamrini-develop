import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/food_model.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/features/trainee/presentation/views/widgets/remove_diet_course_widget.dart';

import '../diet_course_details_screen.dart';

class DietCourseItemWidget extends StatelessWidget {
  const DietCourseItemWidget(
      {super.key, required this.model, required this.food, required this.logo});
  final TraineeModel? model;
  final FoodModel food;
  final String logo;

  @override
  Widget build(BuildContext context) {
    var userType = CacheHelper.getData(key: 'usertype');
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          navigateTo(
              context,
              DietCourseDetailsScreen(
                food: food,
                logo: logo,
              ));
        },
        child: Container(
          decoration: BoxDecoration(
            color: appColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: width / 2),
                      child: Text(
                        food.title,
                        style: TextStyles.style16Bold.copyWith(
                          color: appColor,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Text(
                      DateFormat('M/d/y', 'en').format(food.createdAt.toDate()),
                      style: TextStyles.style13.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                const Spacer(),
                if (model != null)
                  if (userType == UserType.trainer)
                    RemoveDietCourseWidget(
                      food: food,
                      model: model!,
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
