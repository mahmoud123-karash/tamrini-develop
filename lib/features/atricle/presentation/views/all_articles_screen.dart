import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/widgets/banner_ad_widget.dart';
import 'package:tamrini/generated/l10n.dart';
import 'widgets/all_articles_content_builder_widget.dart';

class AllArticlesScreen extends StatelessWidget {
  const AllArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).articlesT),
      bottomNavigationBar: const BannerAdWidget(),
      body: const AllArticlesContentBuilderWidget(),
    );
  }
}
