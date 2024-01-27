import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/generated/l10n.dart';

class PendingArticlesScreen extends StatelessWidget {
  const PendingArticlesScreen({super.key, required this.list});
  final List<ArticleModel> list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).penging_articles),
    );
  }
}
