import 'package:flutter/material.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/pending_articles_custom_button_widget.dart';
import 'add_article_custom_button_widget.dart';

class AddArticleRowWidget extends StatelessWidget {
  const AddArticleRowWidget(
      {super.key,
      required this.length,
      required this.isWriter,
      required this.isUserProfile});
  final int length;
  final bool isWriter, isUserProfile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isUserProfile) const AddArticleCustomButtonWidget(),
          if (!isUserProfile)
            const SizedBox(
              width: 5,
            ),
          Expanded(
            child: PendingArticlesCustomButtonWidget(
              length: length,
              isWriter: isWriter,
            ),
          )
        ],
      ),
    );
  }
}
