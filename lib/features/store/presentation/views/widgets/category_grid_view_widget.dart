import 'package:flutter/material.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'package:tamrini/features/store/data/models/category_model/category_model.dart';
import 'package:tamrini/features/store/presentation/views/widgets/category_product_item_widget.dart';
import 'package:tamrini/features/store/presentation/views/widgets/other_category_item_widget.dart';

class GategoryGridViewWidget extends StatelessWidget {
  const GategoryGridViewWidget({
    super.key,
    required this.list,
    required this.products,
  });
  final List<CategoryModel> list;
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 20),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 10,
      ),
      itemCount: list.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index < list.length) {
          List<ProductModel> categoryList = products
              .where((element) => element.type == list[index].title)
              .toList();
          return categoryList.isNotEmpty
              ? CategoryProductItemWidget(
                  model: list[index],
                  list: categoryList,
                  name: list[index].title,
                )
              : Container();
        } else {
          List<ProductModel> list = products
              .where((element) => element.type == 'أخري')
              .where((element) => element.available == true)
              .toList();
          return list.isNotEmpty
              ? OtherCategoryItemWidget(
                  list: list,
                )
              : Container();
        }
      },
    );
  }
}
