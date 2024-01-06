import 'package:flutter/material.dart';
import 'package:tamrini/features/home/data/models/store_model/product_model.dart';
import 'package:tamrini/features/store/presenrtation/views/widgets/all_product_widget.dart';
import 'package:tamrini/features/store/presenrtation/views/widgets/category_grid_view_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class CategoryProductScreen extends StatelessWidget {
  const CategoryProductScreen({super.key, required this.list});
  final List<ProductModel> list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).category),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AllProductsWidget(list: list),
              const SizedBox(
                height: 40,
              ),
              CategoryGridViewBuilderWidget(products: list),
            ],
          ),
        ),
      ),
    );
  }
}
