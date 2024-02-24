import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/widgets/category_item_widget.dart';
import 'package:tamrini/features/diet_food/presentation/views/diet_food_screen.dart';
import 'package:tamrini/features/diet_food/presentation/views/widgets/article_widget_builder_widget.dart';
import 'package:tamrini/features/questions/presentation/views/questions_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class EducateYourSelfScreen extends StatelessWidget {
  const EducateYourSelfScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const ArticleWidgetBuilderWidget(),
          CategoryItemWidget(
            image: Assets.imagesDiet,
            lable: S.of(context).diet_food,
            onPressed: () {
              navigateTo(context, const DietFoodScreen());
            },
          ),
          CategoryItemWidget(
            image: Assets.imagesQuestion,
            lable: S.of(context).questtion,
            onPressed: () {
              navigateTo(context, const QuestionsScreen());
            },
          )
        ],
      ),
    );
  }
}
