import 'package:flutter/material.dart';
import 'package:tamrini/features/atricle/presentation/views/widgets/aricles_item_widget.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';

class ArticleListViewWidget extends StatelessWidget {
  const ArticleListViewWidget({
    super.key,
    required this.list,
    required this.length,
    required this.controller,
  });
  final List<ArticleModel> list;
  final int length;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    list.sort((a, b) => b.date!.compareTo(a.date!));
    final mediaQuery = MediaQuery.of(context);
    final getWidht = mediaQuery.size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListView.separated(
        controller: controller,
        itemCount: list.length <= length ? list.length : length + 1,
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
      ),
    );
  }
}
