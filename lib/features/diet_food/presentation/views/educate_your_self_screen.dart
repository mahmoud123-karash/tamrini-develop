import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/assets.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/diet_food/presentation/views/diet_food_screen.dart';
import 'package:tamrini/features/diet_food/presentation/views/widgets/article_widget_builder_widget.dart';
import 'package:tamrini/features/diet_food/presentation/views/widgets/artilcle_container_widget.dart';
import 'package:tamrini/features/questions/presentation/views/questions_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class EducateYourSelfScreen extends StatefulWidget {
  const EducateYourSelfScreen({Key? key}) : super(key: key);

  @override
  State<EducateYourSelfScreen> createState() => _EducateYourSelfScreenState();
}

class _EducateYourSelfScreenState extends State<EducateYourSelfScreen> {
  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage(Assets.imagesArticalesBanner), context);
    precacheImage(const AssetImage(Assets.imagesDiet), context);
    precacheImage(const AssetImage(Assets.imagesQuestion), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ArticleWidgetBuilderWidget(),
        ArticleContainerWidget(
          image: Assets.imagesDiet,
          lable: S.of(context).diet_food,
          onPressed: () {
            navigateTo(context, const DietFoodScreen());
          },
        ),
        ArticleContainerWidget(
          image: Assets.imagesQuestion,
          lable: S.of(context).questtion,
          onPressed: () {
            navigateTo(context, const QuestionsScreen());
          },
        )
      ],
    );
  }
}
