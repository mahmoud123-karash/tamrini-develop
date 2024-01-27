import 'package:flutter/material.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/pending_articles_custom_button_widget.dart';
import 'add_article_custom_button_widget.dart';

class AddArticleRowWidget extends StatelessWidget {
  const AddArticleRowWidget({super.key, required this.list});
  final List<ArticleModel> list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AddArticleCustomButtonWidget(),
          const SizedBox(
            width: 5,
          ),
          PendingArticlesCustomButtonWidget(list: list)
        ],
      ),
    );
  }
}
