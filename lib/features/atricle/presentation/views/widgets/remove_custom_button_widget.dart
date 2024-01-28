import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'icon_remove_article_widget.dart';

class RemoveCustomButtonWidget extends StatelessWidget {
  const RemoveCustomButtonWidget({super.key, required this.model});
  final ArticleModel model;

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid');
    String userType = CacheHelper.getData(key: 'usertype');

    return model.writerUid == uid
        ? userType == 'admin' || userType == 'writer'
            ? IconRemoveArticleWidget(model: model)
            : Container()
        : model.isRefused! && userType == 'admin'
            ? IconRemoveArticleWidget(model: model)
            : Container();
  }
}
