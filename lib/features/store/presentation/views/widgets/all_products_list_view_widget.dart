import 'package:flutter/material.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'package:tamrini/features/store/presentation/views/widgets/product_item_widget.dart';

class AllProductsListViewWidget extends StatelessWidget {
  const AllProductsListViewWidget({
    super.key,
    required this.list,
  });
  final List<ProductModel> list;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 20),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ProductItemWidget(
          model: list[index],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemCount: list.length,
    );
  }
}
