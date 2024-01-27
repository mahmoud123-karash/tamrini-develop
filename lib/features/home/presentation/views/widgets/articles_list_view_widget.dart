import 'package:flutter/material.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/aricles_item_widget.dart';

class ArticlesListViewWidget extends StatelessWidget {
  const ArticlesListViewWidget({super.key, required this.models});
  final List<ArticleModel> models;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getHeight = mediaQuery.size.height;
    final getWidht = mediaQuery.size.width;

    return SizedBox(
      height: getHeight * 0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: models.length > 5 ? 5 : models.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return AtricleItemWidget(
            width: getWidht - 70,
            model: models[index],
          );
        },
      ),
    );
  }
}
