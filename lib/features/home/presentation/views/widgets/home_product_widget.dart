import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/home/data/models/store_model/product_model.dart';
import 'package:tamrini/features/home/data/models/store_model/store_model.dart';
import 'package:tamrini/features/home/presentation/views/widgets/home_product_list_view.dart';
import 'package:tamrini/features/home/presentation/views/widgets/title_and_more_button_row_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../../store/presenrtation/views/stores_screen.dart';

class HomeProductWidget extends StatelessWidget {
  const HomeProductWidget(
      {super.key, required this.stores, required this.products});
  final List<StoreModel> stores;
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TitleAndMoreButtonRowWidget(
          lable: S.of(context).products,
          onPressed: () {
            navigateTo(context, StoresScreen(stores: stores));
          },
        ),
        const SizedBox(
          height: 10,
        ),
        ProductsListViewWidget(
          models: products,
        ),
        const Divider(
          height: 50,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }
}
