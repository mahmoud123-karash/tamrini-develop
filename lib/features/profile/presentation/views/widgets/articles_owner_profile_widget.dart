import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/atricle/presentation/views/all_articles_screen.dart';
import 'package:tamrini/generated/l10n.dart';
import '../../../../atricle/presentation/views/widgets/aricles_item_widget.dart';
import '../../../../atricle/data/models/article_model/article_model.dart';
import 'name_text_widget.dart';

class ArticlesOwnerProfileWidget extends StatelessWidget {
  const ArticlesOwnerProfileWidget(
      {super.key, required this.list, required this.id});
  final List<ArticleModel> list;
  final String id;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getWidth = mediaQuery.size.width;
    return list.isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: NameTextWidget(text: S.of(context).store),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: TextButton(
                      onPressed: () {
                        navigateTo(
                          context,
                          AllArticlesScreen(
                            id: id,
                            isUserProfile: true,
                          ),
                        );
                      },
                      child: Text(S.of(context).more),
                    ),
                  )
                ],
              ),
              AtricleItemWidget(
                model: list.first,
                width: getWidth,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
  }
}
