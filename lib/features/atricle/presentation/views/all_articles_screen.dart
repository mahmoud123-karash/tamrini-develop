import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/widgets/banner_ad_widget.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_cubit.dart';
import 'package:tamrini/generated/l10n.dart';
import 'widgets/all_articles_content_builder_widget.dart';

class AllArticlesScreen extends StatelessWidget {
  const AllArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).articlesT),
      bottomNavigationBar: const BannerAdWidget(),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1500)).then(
            (value) {
              ArticlesCubit.get(context).getData();
            },
          );
        },
        child: const AllArticlesContentBuilderWidget(),
      ),
    );
  }
}
