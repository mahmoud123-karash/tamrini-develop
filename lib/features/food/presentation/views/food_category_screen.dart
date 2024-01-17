import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';

import '../../../../generated/l10n.dart';
import 'supplement_category_screen.dart';
import 'widgets/food_category_item_widget.dart';

class FoodCategoryScreen extends StatefulWidget {
  const FoodCategoryScreen({Key? key}) : super(key: key);

  @override
  State<FoodCategoryScreen> createState() => _FoodCategoryScreenState();
}

class _FoodCategoryScreenState extends State<FoodCategoryScreen> {
  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage(Assets.imagesNutiritious), context);
    precacheImage(const AssetImage(Assets.imagesProtien), context);
    precacheImage(const AssetImage(Assets.imagesWhey), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FoodCategoryItemWidget(
          onPressed: () {},
          image: Assets.imagesNutiritious,
          lable: S.of(context).values_food,
        ),
        FoodCategoryItemWidget(
          onPressed: () {},
          image: Assets.imagesProtien,
          lable: S.of(context).protien_calculator,
        ),
        FoodCategoryItemWidget(
          onPressed: () {
            navigateTo(context, const SupplementsCategoryScreen());
          },
          image: Assets.imagesWhey,
          lable: S.of(context).nuttritions,
        ),
      ],
    );
  }
}
