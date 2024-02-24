import 'package:flutter/material.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'package:tamrini/generated/l10n.dart';

import 'all_products_list_view_widget.dart';
import 'category_grid_view_builder_widget.dart';
import 'custom_group_buttons_widget.dart';

class StoreCategoryColumWidget extends StatefulWidget {
  const StoreCategoryColumWidget(
      {super.key, required this.list});
  final List<ProductModel> list;

  @override
  State<StoreCategoryColumWidget> createState() =>
      _StoreCategoryColumWidgetState();
}

class _StoreCategoryColumWidgetState extends State<StoreCategoryColumWidget> {
  bool isTapped = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomGroupButtonWidget(
            onPressedP: () {
              isTapped = true;
              setState(() {});
            },
            onPressedB: () {
              isTapped = false;
              setState(() {});
            },
            isTapped: isTapped,
          ),
          widget.list.isEmpty
              ? Expanded(
                  child: Center(
                    child: Text(
                      S.of(context).no_products_yet,
                    ),
                  ),
                )
              : !isTapped
                  ? AllProductsListViewWidget(
                      list: widget.list,
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: CategoryGridViewBuilderWidget(
                        products: widget.list,
                      ),
                    ),
        ],
      ),
    );
  }
}
