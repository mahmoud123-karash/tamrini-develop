import 'package:flutter/material.dart';
import 'package:tamrini/features/home/data/models/store_model/product_model.dart';
import 'package:tamrini/features/store/presentation/views/widgets/store_best_seller_product_item_widget.dart';

class StoreBestSellerProducctListViewWidget extends StatelessWidget {
  const StoreBestSellerProducctListViewWidget({super.key, required this.list});
  final List<ProductModel> list;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) => StoreBestSellerProductItemWidget(
        model: list[index],
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemCount: list.length,
    );
  }
}