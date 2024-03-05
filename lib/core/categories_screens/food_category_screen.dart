import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/food/presentation/views/protein_calculator_screen.dart';
import 'package:tamrini/features/my_day/presentation/views/my_day_screen.dart';

import '../../generated/l10n.dart';
import '../../features/nutrition/presentation/views/nutrition_classification_screen.dart';
import '../../features/food/presentation/views/supplement_category_screen.dart';
import '../widgets/category_item_widget.dart';

class FoodCategoryScreen extends StatelessWidget {
  const FoodCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid') ?? '';
    return SingleChildScrollView(
      child: Column(
        children: [
          CategoryItemWidget(
            onPressed: () {
              navigateTo(context, const NutritionClassificationScreen());
            },
            image: Assets.imagesNutiritious,
            lable: S.of(context).values_food,
          ),
          CategoryItemWidget(
            onPressed: () {
              navigateTo(context, const ProteinCalculatorScreen());
            },
            image: Assets.imagesProtien,
            lable: S.of(context).protien_calculator,
          ),
          CategoryItemWidget(
            onPressed: () {
              navigateTo(
                  context, const SupplementsCategoryScreen(isCourse: false));
            },
            image: Assets.imagesWhey,
            lable: S.of(context).nuttritions,
          ),
          if (uid != '')
            CategoryItemWidget(
              onPressed: () {
                navigateTo(context, const MyDayScreen());
              },
              image: Assets.imagesMyDay,
              lable: S.of(context).my_day,
            ),
        ],
      ),
    );
  }
}
