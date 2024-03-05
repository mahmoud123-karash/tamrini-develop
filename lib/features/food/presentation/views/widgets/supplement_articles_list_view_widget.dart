import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/features/food/data/models/supplement_model/supplement_data.dart';
import 'package:tamrini/features/food/presentation/views/widgets/supplement_article_item_widget.dart';

class SupplementAriclesListViewWidget extends StatelessWidget {
  const SupplementAriclesListViewWidget(
      {super.key,
      required this.length,
      required this.list,
      required this.scrollController,
      required this.categoryId,
      required this.isCourse});
  final int length;
  final List<SupplementData> list;
  final ScrollController scrollController;
  final String categoryId;
  final bool isCourse;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListView.separated(
        controller: scrollController,
        itemBuilder: (context, index) {
          if (index < length) {
            return SupplementArticleItemWidget(
              model: list[index],
              categoryId: categoryId,
              isCourse: isCourse,
            );
          }
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: CircularProgressIndicator(),
            ),
          );
        },
        itemCount: list.length <= length ? list.length : length + 1,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 5.h,
          );
        },
      ),
    );
  }
}
