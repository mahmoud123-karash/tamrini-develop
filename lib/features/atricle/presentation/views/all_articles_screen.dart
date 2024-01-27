import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../data/models/article_model/article_model.dart';
import 'widgets/all_articles_content_builder_widget.dart';

class AllArticlesScreen extends StatelessWidget {
  const AllArticlesScreen({super.key, this.models});
  final List<ArticleModel>? models;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        S.of(context).articlesT,
      ),
      body: AllArticlesContentBuilderWidget(models: models),
    );
  }
}
