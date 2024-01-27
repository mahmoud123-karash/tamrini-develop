import 'package:flutter/material.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_cubit.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/artilcle_custom_button_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class ArticleBanCustomButtonWidget extends StatelessWidget {
  const ArticleBanCustomButtonWidget(
      {super.key, required this.article, required this.token});
  final ArticleModel article;
  final String token;

  @override
  Widget build(BuildContext context) {
    return ArticleCustomButtonWidget(
      color: Colors.red,
      lable: S.of(context).ban_article,
      onPressed: () {
        ArticlesCubit.get(context).updateArticle(
          oldModel: article,
          isAcceped: false,
          token: token,
          context: context,
          title: 'ban',
        );
      },
    );
  }
}
