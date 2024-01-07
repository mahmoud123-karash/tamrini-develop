import 'package:flutter/material.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/aricles_item_widget.dart';
import 'package:tamrini/features/home/data/models/article_model/article_model.dart';

class ArticleListViewWidget extends StatelessWidget {
  const ArticleListViewWidget(
      {super.key, required this.list, required this.length});
  final List<ArticleModel> list;
  final int length;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final getWidht = mediaQuery.size.width;
    return ListView.separated(
      itemCount: list.length < length ? list.length : length + 1,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (index < length) {
          return AtricleItemWidget(
            width: getWidht,
            model: list[index],
          );
        } else {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 20,
        );
      },
    );
  }
}
