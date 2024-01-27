import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/accept_refuse_row_buttons_widget.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/writer_row_widget.dart';
import 'package:tamrini/features/questions/data/models/user_model/user_model.dart';

import 'article_ban_custom_button_widget.dart';

class ArticleWriterWidget extends StatelessWidget {
  const ArticleWriterWidget({
    super.key,
    required this.model,
    required this.article,
  });
  final UserModel model;
  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    String userType = CacheHelper.getData(key: 'usertype');
    String uid = CacheHelper.getData(key: 'uid');
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Column(
        children: [
          WriterRowWidget(model: model),
          if (userType == 'admin' && uid != article.writerUid) const Divider(),
          if (!article.isPending! &&
              userType == 'admin' &&
              uid != article.writerUid)
            ArticleBanCustomButtonWidget(article: article, token: model.token),
          if (article.isPending!)
            AcceptRefuseButtonsWidget(
              article: article,
              token: model.token,
            ),
        ],
      ),
    );
  }
}
