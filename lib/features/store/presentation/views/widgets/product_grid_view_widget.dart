import 'package:flutter/material.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'store_product_item_widget.dart';

class ProductGridViewWidget extends StatelessWidget {
  const ProductGridViewWidget({super.key, required this.models});
  final List<ProductModel> models;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: models.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 5 / 7,
      ),
      itemBuilder: (context, index) => StoreProductItemWidget(
        model: models[index],
      ),
    );
  }
}
