import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/user_type.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/features/atricle/presentation/views/new_article_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class EditArticleCustomButtonWidget extends StatelessWidget {
  const EditArticleCustomButtonWidget({super.key, required this.model});
  final ArticleModel model;

  @override
  Widget build(BuildContext context) {
    String uid = CacheHelper.getData(key: 'uid') ?? '';
    String userType = CacheHelper.getData(key: 'usertype') ?? '';
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (userType == UserType.admin)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            child: customButton(
              onPressed: () {
                navigateTo(
                  context,
                  NewArticleScreen(model: model),
                );
              },
              lable: S.of(context).edit,
            ),
          ),
        if (userType == UserType.writer && model.writerUid == uid)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            child: customButton(
              onPressed: () {
                navigateTo(
                  context,
                  NewArticleScreen(model: model),
                );
              },
              lable: S.of(context).edit,
            ),
          )
      ],
    );
  }
}
