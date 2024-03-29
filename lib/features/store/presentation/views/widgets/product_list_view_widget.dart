import 'package:flutter/material.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'package:tamrini/features/store/presentation/views/widgets/product_item_widget.dart';

class ProductListViewWidget extends StatelessWidget {
  const ProductListViewWidget({
    super.key,
    required this.list,
    required this.length,
    required this.scrollController,
  });
  final List<ProductModel> list;
  final int length;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      itemBuilder: (context, index) {
        if (index < length) {
          return ProductItemWidget(
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
      itemCount: list.length <= length ? list.length : length + 1,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 30,
        );
      },
    );
  }
}
