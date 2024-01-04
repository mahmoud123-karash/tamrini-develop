import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/home/data/models/article_model/article_model.dart';
import 'package:tamrini/features/home/presentation/views/widgets/articles_list_view_widget.dart';
import 'package:tamrini/features/home/presentation/views/widgets/title_and_more_button_row_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../all_articles_screen.dart';

class HomeProductsWidget extends StatelessWidget {
  const HomeProductsWidget({super.key, required this.list});
  final List<ArticleModel> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TitleAndMoreButtonRowWidget(
          lable: S.of(context).articles,
          onPressed: () {
            navigateTo(context, AllArticlesScreen(models: list));
          },
        ),
        const SizedBox(
          height: 10,
        ),
        ArticlesListViewWidget(
          models: list,
        ),
        const Divider(
          height: 50,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }
}
