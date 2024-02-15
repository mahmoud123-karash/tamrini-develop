import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/favourite/data/models/meal_model/meal_model.dart';
import 'package:tamrini/features/favourite/presentation/manager/favorite_cubit/favorite_cubit.dart';

class MealNameIconRowWidget extends StatelessWidget {
  const MealNameIconRowWidget({
    super.key,
    required this.meal,
  });
  final MealModel meal;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: width / 1.5),
          child: Text(
            meal.name,
            style: TextStyles.style16Bold.copyWith(
              color: appColor,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
          ),
        ),
        const Spacer(),
        IconButton(
            onPressed: () {
              FavoriteCubit.get(context).removeFavoriteMeal(meal: meal);
            },
            icon: const Icon(Ionicons.heart, color: Colors.red))
      ],
    );
  }
}
